class MessageObserver < ActiveRecord::Observer
  
  def after_save(message)
    Notifications.new_email(message).deliver
  end
  
end
