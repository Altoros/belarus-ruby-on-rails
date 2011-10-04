class Notifier < ActionMailer::Base
  default from: "no-reply@belarusrubyonrails.org"

  def custom(to, subject, body)
    mail(:to => to, :subject => subject, :body => body)
  end
end
