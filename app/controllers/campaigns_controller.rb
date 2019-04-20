class CampaignsController < ApplicationController
    
    before_action :authenticate_user!
    before_action :set_campaign, only: [:edit,:update,:destroy,:show]
    
    def index
        if current_user.admin
            if params[:search].present?
                @campaigns = Campaign.joins(:user).where("campaigns.name ILIKE ? OR users.username ILIKE?","%#{params[:search]}%", "%#{params[:search]}%")
            else
                @campaigns = Campaign.all.includes(:user)
                # @campaigns = Campaign.search(params[:search])
            end
        else
            @campaigns = Campaign.all.includes(:user)
            if params[:search].present?
                @campaigns = Campaign.joins(:user).where("campaigns.name ILIKE ? OR users.username ILIKE?","%#{params[:search]}%", "%#{params[:search]}%")
            end
        end
    end
    def new
        @campaign = Campaign.new()
    end
    def create
        @campaign = current_user.campaigns.new(campaign_params)
        if @campaign.save
            flash[:notice] = "Campaign created successfully!"
            redirect_to(@campaign)
        else
           flash[:alert] = "Something went wrong"
           render('new') 
        end
    end
    def edit
    end
    def update
        if @campaign.update(campaign_params)
            redirect_to campaign_path(@campaign) ,notice: "Updated Successfully."
        else
            redirect_back(fallback_location, edit_campaign_path(@campaign),alert: "Something went wrong. Please try again.")
        end
    end
    def show
    end
    def destroy
        if @campaign.destroy
            redirect_to campaigns_path
        else
            redirect_back(fallback_location: @campaign,alert: "Something went wrong. Please try again.")
        end
    end
    
    private
    def set_campaign
       @campaign = Campaign.find(params[:id]) 
    end
    
    def campaign_params
        params.require(:campaign).permit(:name, :occ_type, :occ_date, :image, :user_id, :occ_details, :occ_funds)
    end
end
