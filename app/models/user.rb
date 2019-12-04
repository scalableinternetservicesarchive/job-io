class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  mount_uploader :resume, ResumeUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # attr_accessible :email, :encrypted_password, :username, :first_name, :last_name, :summary, :remember_me, :resume_link, :resume_link_cache, :remove_resume_link
  has_and_belongs_to_many :companies
end
