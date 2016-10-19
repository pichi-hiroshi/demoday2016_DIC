class Post < ActiveRecord::Base
    mount_uploader :avatar, AvatarUploader
#    validates :title, presence: true
#    validates :message, presence: true
    belongs_to :user
    belongs_to :board
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy
    def like_user(user_id)
      likes.find_by(user_id: user_id)
    end
end