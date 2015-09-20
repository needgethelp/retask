class Task < ActiveRecord::Base
 has_many :assignments
 has_many :users, through: :assignments
  
 has_many :fellowships
 has_many :users, through: :fellowships
end
