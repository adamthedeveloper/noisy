# Account(id: integer, email: string, encrypted_password: string, password_salt: string, reset_password_token: string, remember_token: string, remember_created_at: datetime, sign_in_count: integer, current_sign_in_at: datetime, last_sign_in_at: datetime, current_sign_in_ip: string, last_sign_in_ip: string, authentication_token: string, created_at: datetime, updated_at: datetime)
Account.create!(:email => 'user@no_profile.com', :password => 'password', :password_salt => '')

Account.create!(:email => 'alameda@example.com', :password => 'password', :password_salt => '')