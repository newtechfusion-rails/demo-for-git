class ListMailer < ActionMailer::Base


  def share_list_email(user, email)
    @user = user
    @url  = "http://192.168.1.28:3005"
    mail(:from => "watet@gmail.com")
    mail(:to => email, :subject => "Your friend wants to share his list with you")
  end

  def share_contact_email(message, name, subject,email)
    puts"fffffffffffffffffffffffffffffffff#{name.inspect}"
    @url  = "http://192.168.1.28:3005"
    @subject = subject
    @message = message
    @email = email
    mail(:from => "watet@gmail.com" )
    mail(:to => "yogesh.waghmare@newtechfusion.com",:subject => subject)
  end
end
