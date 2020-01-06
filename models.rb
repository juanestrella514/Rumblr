class User < ActiveRecord::Base
    validates :firstname, :lastname, :password, presence: true
    validates :email,  uniqueness: true
    validates :password, length: {minimum: 5, max: 8}
end

    
