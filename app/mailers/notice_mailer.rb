class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_blog.subject
  #
  def sendmail_blog(post)
    @greeting = "Hi"

    mail to: "hrs.takahashi7@gmail.com",
      subject: 'Newslideからお問い合わせが来ました'
  end
  
  def sendmail_contact(contact)
    @contact = contact

    mail to: "hrs.takahashi7@gmail.com",
      subject: 'Newslideからお問い合わせが来ました'
  end
  
  def sendmail_reply(contact)
    @contact = contact
    
    mail to: @contact.mail,
      subject: '【Newslide】お問い合わせありがとうございました'
  end
  
end
