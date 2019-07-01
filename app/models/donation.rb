class Donation < ApplicationRecord
    belongs_to :user
    belongs_to :campaign
    belongs_to :request, optional: true
end
