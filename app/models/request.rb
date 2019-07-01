class Request < ApplicationRecord
  belongs_to :campaign
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  has_one :donation

  enum response: [:pending, :processed]

  validates_presence_of :amount
  validates_presence_of :campaign
end
