class UserMailer < ApplicationMailer
  default from: 'practicaII@ing.puc.cl'

  def practice_email(user,email_body)
    email_body = "Siding: \n" +  email_body
    if user
      mail subject: 'Cupo Disponible - Taller de Empleabilidad Práctica II',
           to: user.email,
           body: email_body
    else
      puts '[!] User is null'
    end
  end

  def notice_email(user,email_body)
    email_body = "Email de Funcionamiento del Crawler: \n" +  email_body
    if user
      mail subject: Date.current.strftime("%x").to_s +  "- Crawler Funcionando",
           to: user.email,
           body: email_body
    else
      puts '[!] User is null'
    end
  end

end
