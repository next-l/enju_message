class MessageTemplatesController < InheritedResources::Base
  respond_to :html, :json
  load_and_authorize_resource

  def update
    @message_template = MessageTemplate.find(params[:id])
    if params[:move]
      move_position(@message_template, params[:move])
      return
    end
    update!
  end

  def index
    @message_templates = MessageTemplate.page(params[:page])
  end
end
