class Board < ActiveRecord::Base
    belongs_to :user
    belongs_to :dashboard
    has_many :posts
    
    #1013追加
    
end
