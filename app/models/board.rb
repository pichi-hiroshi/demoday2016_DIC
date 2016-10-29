class Board < ActiveRecord::Base
    belongs_to :user
    belongs_to :dashboard
    has_many :posts
    
    paginates_per 6
    
    
end
