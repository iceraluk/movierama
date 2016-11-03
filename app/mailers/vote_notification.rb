class VoteNotification < ActionMailer::Base
  default from: "from@example.com"

  def notify_user like_or_hate
    mail to: "to@example.com"
  end
end
