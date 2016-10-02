class Post < ActiveRecord::Base
    validates :post_title, presence: true
    validates :post_message, presence: true
    
    belongs_to :user
    
end
