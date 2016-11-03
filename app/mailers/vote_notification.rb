class VoteNotification < ActionMailer::Base
  default from: "noreply@movierama.com"

  def notify_user like_or_hate, movie
    @like_or_hate = like_or_hate.to_s
    @movie = movie
    @user = @movie.user
    subject = 'New ' + @like_or_hate + ' for: ' + @movie.name
    mail to: @user.email, subject: subject
  end
end
