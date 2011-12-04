require 'spec_helper'

describe "messages/new.html.haml" do
  before(:each) do
    assign(:message, stub_model(Message,
      :author => "",
      :recipient => 1,
      :subject => "MyString",
      :body => "MyText",
      :ancestry => "MyString",
      :ancestry_depth => 1
    ).as_new_record)
  end

  it "renders new message form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => messages_path, :method => "post" do
      assert_select "input#message_author", :name => "message[author]"
      assert_select "input#message_recipient", :name => "message[recipient]"
      assert_select "input#message_subject", :name => "message[subject]"
      assert_select "textarea#message_body", :name => "message[body]"
      assert_select "input#message_ancestry", :name => "message[ancestry]"
      assert_select "input#message_ancestry_depth", :name => "message[ancestry_depth]"
    end
  end
end
