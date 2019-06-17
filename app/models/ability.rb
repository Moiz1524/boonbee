class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
      if user.admin
        can :read, :all
        can :update,:all
        cannot :destroy,:all
        can :manage,:admin_panel
        # can :campaign_funds, :campaigns
      else
          cannot :manage,:all
          cannot :update, :campaigns
          cannot :index, Donation
          # cannot :campaign_funds, Campaign
      end

      # if user.admin?
      #   can :read, :all
      #   cannot :update,:all
      #   cannot :destroy,:all
      #   can :manage,:admin_panel
      # else
      #   cannot :manage,:all
      # end
  end
end
