class ProjectMailer < ApplicationMailer
  def project_invoice_email
    @project = params[:project]
    mail(to: @project.email, subject: 'Your invoice is here')
  end
end
