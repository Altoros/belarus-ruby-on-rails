class Notifier < ActionMailer::Base
  def custom(to, subject, body)
    mail(:to => to, :subject => subject, :body => body)
  end

  def comment(to, article)
    @article = article
    mail(:to => to)
  end
end
