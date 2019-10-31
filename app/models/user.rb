class User < ApplicationRecord
    # List of attributes
    attr_accessor :username
    attr_accessor :password
    attr_accessor :email
    attr_accessor :first_name
    attr_accessor :last_name
    attr_accessor :summary
    attr_accessor :resume_link
    attr_reader :start_date
    attr_reader :modified_date

    validates :username, :presence true, :uniqueness true, :length { maximum: 255 }
    before_save { 
        validates :password, :confirmation true
        salt = BCrypt::Engine.generate_salt
        self.password = BCrypt::Engine.hash_secret(password, salt)
     }
    before_save { self.email = email.downcase }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, :presence true, :length { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    validates :first_name, :presence true, :length { maximum: 255 }
    validates :last_name, :presence true, :length { maximum: 255 }
    validates :summary, :length { maximum: 2048 } #TODO: Think about changing this number
    validates :resume_link, :presence true, format: URI::regexp(%w[http https]) #Weak URL checker for S3 link
    
    def start_date=(dt)
        @start_date = dt.to_datetime
    rescue ArgumentError, NoMethodError
        @start_date = nil
    end
    def modified_date=(dt)
        @modified_date = dt.to_datetime
    rescue ArgumentError, NoMethodError
        @start_date = nil
    end
end
