class MessageTemplatesController < ApplicationController
  before_action :set_message_template, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized
  after_action :verify_policy_scoped, :only => :index

  # GET /message_templates
  def index
    authorize MessageTemplate
    @message_templates = policy_scope(MessageTemplate).order(:position).page(params[:page])
  end

  # GET /message_templates/1
  def show
  end

  # GET /message_templates/new
  def new
    @message_template = MessageTemplate.new
    authorize @message_template
  end

  # GET /message_templates/1/edit
  def edit
  end

  # POST /message_templates
  def create
    @message_template = MessageTemplate.new(message_template_params)
    authorize @message_template

    if @message_template.save
      redirect_to @message_template, notice:  t('controller.successfully_created', :model => t('activerecord.models.message_template'))
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /message_templates/1
  def update
    if params[:move]
      move_position(@message_template, params[:move])
      return
    end
    if @message_template.update(message_template_params)
      redirect_to @message_template, notice:  t('controller.successfully_updated', :model => t('activerecord.models.message_template'))
    else
      render action: 'edit'
    end
  end

  # DELETE /message_templates/1
  def destroy
    @message_template.destroy
    redirect_to message_templates_url, notice: 'Message template was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message_template
      @message_template = MessageTemplate.find(params[:id])
      authorize @message_template
    end

    # Only allow a trusted parameter "white list" through.
    def message_template_params
      params.require(:message_template).permit(:status, :title, :body, :locale)
    end
end
