require 'spec_helper'

describe "messages/index.html.haml" do
  before(:each) do
    assign(:messages, [
      stub_model(Message,
        :author => "",
        :recipient => 1,
        :subject => "Subject",
        :body => "MyText",
        :ancestry => "Ancestry",
        :ancestry_depth => 1
      ),
      stub_model(Message,
        :author => "",
        :recipient => 1,
        :subject => "Subject",
        :body => "MyText",
        :ancestry => "Ancestry",
        :ancestry_depth => 1
      )
    ])
  end

  it "renders a list of messages" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Ancestry".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
