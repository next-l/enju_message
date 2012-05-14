class MessageRequestsController < ApplicationController
  load_and_authorize_resource

  # GET /message_requests
  # GET /message_requests.json
  def index
    case params[:mode]
    when 'sent'
      @message_requests = MessageRequest.sent.order('created_at DESC').page(params[:page])
    when 'all'
      @message_requests = MessageRequest.order('created_at DESC').page(params[:page])
    else
      @message_requests = MessageRequest.not_sent.order('created_at DESC').page(params[:page])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @message_requests }
    end
  end

  # GET /message_requests/1
  # GET /message_requests/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @message_request }
    end
  end

  # GET /message_requests/1/edit
  def edit
    @message_templates = MessageTemplate.all
  end

  # PUT /message_requests/1
  # PUT /message_requests/1.json
  def update
    respond_to do |format|
      if @message_request.update_attributes(params[:message_request])
        flash[:notice] = t('controller.successfully_updated', :model => t('activerecord.models.message_request'))
        format.html { redirect_to(@message_request) }
        format.json { head :no_content }
      else
        @message_templates = MessageTemplate.all
        format.html { render :action => "edit" }
        format.json { render :json => @message_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /message_requests/1
  # DELETE /message_requests/1.json
  def destroy
    @message_request.destroy

    respond_to do |format|
      format.html { redirect_to message_requests_url }
      format.json { head :no_content }
    end
  end
end
