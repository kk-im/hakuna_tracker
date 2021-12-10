class ProjectMailer < ApplicationMailer
  def project_invoice_email
    @project = params[:project]
    attachments.inline["logo.png"] = File.read("app/assets/images/logo.png")
    mail(to: @project.email, subject: 'Your invoice is here')
  end
end
