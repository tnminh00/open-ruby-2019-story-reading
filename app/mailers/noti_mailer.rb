class NotiMailer < ApplicationMailer
  def notification user, story
    subject = story.name

    mail to: user.email, subject: subject do |format|
      format.html { render locals: {user: user, story: story} }
    end
  end

  def weekly_noti user
    subject = t ".subject"

    mail to: user.email, subject: subject
  end
end
