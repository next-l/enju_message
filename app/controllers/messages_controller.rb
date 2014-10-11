class MessagesController < ApplicationController
  load_and_authorize_resource except: [:index, :show]
  authorize_resource only: [:index, :show]
  before_filter :get_user, only: :index
  after_filter :solr_commit, only: [:create, :update, :destroy, :destroy_selected]

  # GET /messages
  # GET /messages.json
  def index
    query = @query = params[:query].to_s.strip
    search = Sunspot.new_search(Message, include: [:sender])
    user = current_user
    case params[:mode]
    when 'read'
      is_read = true
    when 'unread'
      is_read = false
    else
      is_read = nil
    end
    search.build do
      fulltext query
      order_by :created_at, :desc
      with(:receiver_id).equal_to user.id
      facet(:is_read)
    end
    @message_facet =  Hash[*search.execute!.facet_response['facet_fields']['is_read_b']]
    search.build do
      with(:is_read).equal_to is_read unless is_read.nil?
    end
    page = params[:page] || 1
    search.query.paginate(page.to_i, Message.default_per_page)
    @messages = search.execute!.results

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
      format.rss
      format.atom
    end
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @message = current_user.received_messages.find(params[:id])
    @message.transition_to!(:read) if @message.current_state != 'read'

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/new
  def new
    parent = get_parent(params[:parent_id])
    @message = current_user.sent_messages.new
    if params[:recipient] && current_user.has_role?('Librarian')
      @message.recipient = params[:recipient]
    else
      @message.recipient = parent.sender.username if parent
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @message }
    end
  end

  # GET /messages/1/edit
  def edit
    @message = current_user.received_messages.find(params[:id])
    @message.transition_to!(:read)
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(params[:message])
    @message.sender = current_user
    get_parent(@message.parent_id)
    @message.receiver = User.find(@message.recipient) rescue nil

    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_url, notice: t('controller.successfully_created', model: t('activerecord.models.message')) }
        format.json { render json: @message, status: :created, location: @message }
      else
        format.html { render action: "new" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.json
  def update
    @message = current_user.received_messages.find(params[:id])

    if @message.update_attributes(params[:message])
      format.html { redirect_to @message, notice: t('controller.successfully_updated', model: t('activerecord.models.message')) }
      format.json { head :no_content }
    else
      format.html { render action: "edit" }
      format.json { render json: @message.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message = current_user.received_messages.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url }
      format.json { head :no_content }
    end
  end

  def destroy_selected
    if current_user
      unless current_user.has_role?('Librarian')
        access_denied
      end
    else
      redirect_to new_user_session_url
      return
    end
    respond_to do |format|
      if params[:delete].present?
        messages = params[:delete].map{|m| Message.find_by_id(m)}
      end
      if messages.present?
        messages.each do |message|
          message.destroy
        end
        flash[:notice] = t('message.messages_were_deleted')
        format.html { redirect_to messages_url }
      else
        flash[:notice] = t('message.select_messages')
        format.html { redirect_to messages_url }
      end
    end
  end

  private
  def get_parent(id)
    parent = Message.where(id: id).first
    unless current_user.has_role?('Librarian')
      unless parent.try(:receiver) == current_user
        access_denied; return
      end
    else
      parent
    end
  end
end
