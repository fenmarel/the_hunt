class User < ActiveRecord::Base
  before_validation :ensure_session_token


  def self.generate_token
    SecureRandom::urlsafe_base64(24)
  end

  def self.find_by_credentials(user_params)
    user = User.find_by_username(user_params[:username])

    return user if user && user.is_password?(user_params[:password])

    nil
  end

  def password=(plaintext)
    @password = plaintext
    self.password_digest = BCrypt::Password.create(@password)
  end

  def is_password?(plaintext)
    BCrypt::Password.new(self.password_digest).is_password?(plaintext)
  end

  def confirms_password(confirmation)
    @password == confirmation
  end

  def reset_session_token!
    self.session_token = self.class.generate_token
    self.save!

    self.session_token
  end


  private

  def ensure_session_token
    self.session_token ||= self.class.generate_token
  end

end