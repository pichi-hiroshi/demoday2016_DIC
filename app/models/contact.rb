class Contact < ActiveRecord::Base
    validates :contents, presence: true
    validates :mail, presence: true
#    validates :terms, acceptance: true
#    validates :privacy, acceptance: true
    
end
