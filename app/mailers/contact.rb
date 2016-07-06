class Contact < ApplicationMailer
  helper ApplicationHelper
  layout 'contact'

  def email(name, email, body)
    @body = body
    mail(to: "marin@norra.fr", from: email, subject: 'Contact Request from ' + name + ' - norra.fr')
  end
end
