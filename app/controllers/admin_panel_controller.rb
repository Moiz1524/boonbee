class AdminPanelController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource class: false
  
  def index
  end

  def users
    @users = User.where.not(id: current_user.id)
  end
  
  def all_campaigns
    if params[:search].present?
        @campaigns = Campaign.joins(:user).where("campaigns.name ILIKE ? OR users.username ILIKE?","%#{params[:search]}%", "%#{params[:search]}%")
    else
        @campaigns = Campaign.all.includes(:user)
        # @campaigns = Campaign.search(params[:search])
    end
  end
end
