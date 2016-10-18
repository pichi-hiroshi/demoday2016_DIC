class Post < ActiveRecord::Base
#    validates :title, presence: true
#    validates :message, presence: true
    
    belongs_to :user
    belongs_to :board
    has_many :comments, dependent: :destroy
    
end