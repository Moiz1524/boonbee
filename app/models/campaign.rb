class Campaign < ApplicationRecord
    belongs_to :user
    has_many :donations
    
    enum occ_type: [:festival, :birthday, :funeral]
    
    validates_presence_of :occ_date
    validates_presence_of :occ_type
    
    has_attached_file :image, styles: { medium: "300x300", small: "150x150" },default_url: "/avatar.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end

