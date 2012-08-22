# -*- encoding : utf-8 -*-
class Notifier < ActionMailer::Base
  default :from => "Белорусское сообщество Ruby On Rails <info@belarusrubyonrails.org>", :charset => 'utf-8'

  def broadcast_message(to, subject, body)
    mail(:to => to, :subject => subject, :body => body, :content_type => "text/html")
  end

  def comment(article)
    @article = article
    mail(:to => "info@belarusrubyonrails.org")
  end

  def new_participant_for_meetup(meetup, participant)
    @meetup = meetup
    mail :to => participant.email, :subject => @meetup.letter_subject, :body => @meetup.letter_body, :content_type => "text/html"
  end

  def new_participant_for_meetup_for_admin(meetup, participant)
    @meetup = meetup
    mail :to => "info@belarusrubyonrails.org", :subject => "#{@meetup.topic} - новый участник мероприятия",
      :body => "ID участника: #{participant.id}, email: #{participant.email}"
  end

  def removed_participant_for_meetup_for_admin(meetup, participant)
    @meetup = meetup
    mail :to => "info@belarusrubyonrails.org", :subject => "#{@meetup.topic} - удален участник мероприятия",
      :body => "Email: #{participant.email}"
  end

  def accepted_participant_for_meetup(meetup, participant)
    @meetup = meetup
    mail :to => participant.email, :subject => "#{@meetup.topic} - одобрено участие",
         :body => "Ваше участие одобрено. Мы Вас ждем!"
  end

  def declined_participant_for_meetup(meetup, participant)
    @meetup = meetup
    mail :to => participant.email, :subject => "#{@meetup.topic} - отклонено участие",
         :body => "К сожалению Ваше участие отклонено :("
  end
end
