require 'spec_helper'

describe Message do
  # pending "add some examples to (or delete) #{__FILE__}"
  before :all do
    @volyova = User.create! email: 'volyova@ship.net', password: '123456', password_confirmation: '123456', username: 'volyova' 
    @khouri = User.create! email: 'khouri@ship.net', password: '123456', password_confirmation: '123456', username: 'khouri'
  end
  
  after :all do
    User.delete_all
  end
  
  describe "prepare message testing" do
    it "should by two users in database" do
      User.count.should == 2
    end
  end
  
  
  
end
