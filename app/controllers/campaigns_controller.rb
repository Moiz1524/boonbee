class CampaignsController < ApplicationController
    
    before_action :authenticate_user!
    before_action :set_campaign, only: [:edit,:update,:destroy,:show]
    
    def index
        if current_user.admin
            @campaigns = Campaign.all.includes(:user)
        else
            @campaigns = current_user.campaigns
        end
    end
    def new
        @campaign = Campaign.new()
    end
    def create
        @campaign = current_user.campaigns.new(campaign_params)
        if @campaign.save!
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
            redirect_to campaigns_path ,notice: "Updated Successfully."
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
        params.require(:campaign).permit(:occ_type, :occ_date, :image, :user_id, :occ_details, :occ_funds)
    end
end
