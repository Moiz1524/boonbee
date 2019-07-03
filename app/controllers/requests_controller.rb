class RequestsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:search].present?
      @users = User.where("users.username ILIKE ? OR users.email ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      puts "Hey! I am running!"
      @users = User.where.not(:id => current_user.id)
    end
  end

  def new
    @user = User.find(params[:id])
    if current_user.campaigns == []
      flash[:alert] = "You have no associated campaigns!"
      redirect_to(new_campaign_path)
    end
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    if @request.campaign.active
      if @request.save
        receiver = User.find(@request.receiver_id)
        RequestMailer.with(user: receiver, req_id: @request.id).request_money_email.deliver
        flash[:notice] = "Your request has been submitted."
        redirect_to(myprofile_path)
      else
        flash[:alert] = "Something went wrong"
        # redirect_to(new_request_path(:id => @request.receiver_id))
        render('new', :locals => { :@user => User.find(@request.receiver_id) })
      end
    else
      flash[:alert] = "You cannot make request for an inactive campaign."
      redirect_to(myprofile_path)
    end
  end

  def show
    @request = Request.find(params[:id])
    if @request.response == "processed"
      flash[:alert] = "Request has been processed already!"
      redirect_to(myprofile_path)
    end
  end

  def request_profile
    @user = User.find(params[:id])
  end

  private

  def request_params
    params.require(:request).permit(:amount, :campaign_id, :sender_id, :receiver_id, :response)
  end
end
