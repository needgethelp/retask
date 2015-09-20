class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
    has_one :profile
  
    has_many :assignments
    has_many :tasks, through: :assignments
    
    has_many :fellowships
    has_many :tasks, through: :fellowships
end
