class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.received.subject
  #
  def received
    @greeting = "Hi guillo rails"
	#email = "guillermo.valenciap@utelvt.edu.ec"
	email = "guillovale@yahoo.com"
	mail(to: email, subject: 'Sample Email')
    #mail to: "guillovale@yahoo.com"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.shipped.subject
  #
  def shipped
    @greeting = "Hi guillo rails"

    mail to: "guillovale@yahoo.com"
  end
end
