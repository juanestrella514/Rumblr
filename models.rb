class User < ActiveRecord::Base
    validates :email, :firstname, :lastname, :password, presence: true
    validates :email,  uniqueness: true
    validates :birthday, presence: true
    validates :password, length: {minimum: 5, max: 8}

    has_many :articles, dependent: :destroy
end

class Article < ActiveRecord::Base
    validates :content, presence: true

    belongs_to :user
end
