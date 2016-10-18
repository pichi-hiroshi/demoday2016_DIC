class Post < ActiveRecord::Base
    mount_uploader :avatar, AvatarUploader
#    validates :title, presence: true
#    validates :message, presence: true
    
    belongs_to :user
    belongs_to :board
    has_many :comments, dependent: :destroy
    
end