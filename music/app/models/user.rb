class User < ApplicationRecord
    validates :password, length: {minimum: 6, allow_nil: true }
    validates :password_digest, presence: {message: "password cannot be blank"}
    validates :email, presence: true, uniqueness: true
    after_initialize :ensure_session_token
    attr_reader :password

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)
        if user && user.is_password?(password)
            return user
        else
            return nil

        end
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
        
    end

    def is_password?(password)
        password_check = BCrypt::Password.new(self.password_digest)
        password_check == password
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        self.session_token = SecureRandom::urlsafe_base64
        self.save!
        self.session_token
    end
            # does ensure session token need to be a self.ensure_session_token
    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end

end
#create a user goes to database with a session_token
#
# F I G V A P E R