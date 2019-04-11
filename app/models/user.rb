class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  has_many :campaigns, dependent: :destroy
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_uniqueness_of :email   
  has_attached_file :profile_pic, styles: { medium: "300x300", small: "150x150" },default_url: "/avatar.png"
  validates_attachment_content_type :profile_pic, content_type: /\Aimage\/.*\z/
  
  def make_admin
    self.update!(admin: true)
  end
  
  def name
    return self.first_name + " " + self.last_name
  end
  
end
