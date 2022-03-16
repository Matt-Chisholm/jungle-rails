class OrderMailer < ApplicationMailer
  def order_confirmation(user)
    mail :to => user.email, :from => "no-reply@jungle.com", :subject => "Subject line"
  end
end
