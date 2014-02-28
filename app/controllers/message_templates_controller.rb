class MessageTemplatesController < InheritedResources::Base
  respond_to :html, :json
  load_and_authorize_resource except: [:index, :create]
  authorize_resource only: [:index, :create]

  def index
    @message_templates = MessageTemplate.page(params[:page])
  end

  def update
    @message_template = MessageTemplate.find(params[:id])
    if params[:move]
      move_position(@message_template, params[:move])
      return
    end
    update!
  end

  private
  def permitted_params
    params.permit(
      :message_template => [
        :status, :title, :body, :locale
      ]
    )
  end
end
