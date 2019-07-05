class Campaign < ApplicationRecord
    belongs_to :user
    has_many :donations, dependent: :destroy
    has_many :requests, dependent: :destroy

    enum occ_type: [:birthday, :graduation, :holiday, :other]

    validate :occ_date_cannot_be_in_past
    validates_presence_of :name
    validates_presence_of :occ_date
    validates_presence_of :occ_type
    validates :user_occ, :presence => true, length: { maximum: 20 }

    def self.occ_type_options
      self.occ_types.map { |k,v| [k.capitalize, k] }
    end

    def occ_date_cannot_be_in_past
      if occ_date.present? && occ_date <= Date.today
        errors.add(:occ_date, "can't be in past or today")
      end
    end

    has_attached_file :image, styles: { medium: "300x300", small: "150x150" },default_url: "/avatar.png"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

end
