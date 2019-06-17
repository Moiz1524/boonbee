class CampaignsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_campaign, only: [:edit,:update,:destroy,:show]
    load_and_authorize_resource :only => [:edit, :update, :destroy]

    def index
        if current_user.admin
            if params[:search].present?
                @campaigns = Campaign.joins(:user).where("campaigns.name ILIKE ? OR users.username ILIKE? OR users.phone_number LIKE?","%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
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
        # time = 2.minutes.from_now
        time = (@campaign.occ_date.to_time - 24.hours).to_datetime
        # time = @campaign.occ_date.strftime("%I:%M%p")
        if @campaign.save
            CashOutWorker.perform_at(time, 'MyJob', 2, @campaign.id)
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

    def campaign_funds
        @funds = Campaign.find(params[:id]).donations
        @funds_total = 0
        @funds.each do |f|
           @funds_total = @funds_total + f.amount
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
