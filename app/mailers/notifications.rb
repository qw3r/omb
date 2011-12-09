class Notifications < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifications.new_message.subject
  #
  def new_message(recipient)
    @message = recipient
    mail to: @message.recipient.email
  end
end
