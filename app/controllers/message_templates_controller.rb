class MessageTemplatesController < InheritedResources::Base
  respond_to :html, :json
  load_and_authorize_resource

  def update
    @message_template = MessageTemplate.find(params[:id])
    if params[:position]
      @message_template.insert_at(params[:position])
      redirect_to message_templates_url
      return
    end
    update!
  end

  def index
    @message_templates = MessageTemplate.page(params[:page])
  end
end
