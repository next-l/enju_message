require 'rails_helper'

describe 'messages/index' do
  before(:each) do
    assign(:messages, Message.page(1).per(10))
  end

  it 'renders a list of messages' do
    allow(view).to receive(:policy).and_return double(create?: true, destroy?: true)
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select 'tr>td', count: 10
  end
end
