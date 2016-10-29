class Contact < ActiveRecord::Base
    validates :contents, presence: true
    validates :mail, presence: true
    validates :privacy, acceptance: true
    
end
