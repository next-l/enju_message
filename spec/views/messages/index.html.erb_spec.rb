require 'rails_helper'

describe 'messages/index' do
  before(:each) do
    assign(:messages, Kaminari.paginate_array([
      stub_model(Message,
        sender_id: 1,
        receiver_id: 2,
        created_at: Time.zone.now),
      stub_model(Message,
        sender_id: 1,
        receiver_id: 2,
        created_at: Time.zone.now)
    ]).page(1))
    view.stub(:filtered_params).and_return(ActionController::Parameters.new(per_page: 50).permit(:per_page))
    @message_facet = {}
  end

  it 'renders a list of messages' do
    allow(view).to receive(:policy).and_return double(create?: true, destroy?: true)
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select 'tr>td', count: 9
  end
end
