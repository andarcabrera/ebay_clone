ActionMailer::Base.smtp_settings[:domain] = Rails.application.secrets.smtp_domain
ActionMailer::Base.smtp_settings[:user_name] = Rails.application.secrets.smtp_user_name
ActionMailer::Base.smtp_settings[:password] = Rails.application.secrets.smtp_password

