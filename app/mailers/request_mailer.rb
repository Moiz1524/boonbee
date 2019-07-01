class RequestMailer < ApplicationMailer
  default from: 'Boonbee@example.com'

  def request_money_email
    @user = params[:user]
    request = Request.find(params[:req_id])
    @sender = User.find(request.sender_id)
    @url = "http://localhost:3000/requests/#{request.id}"
    mail(to: @user.email, subject: 'Request to act upon!.')
  end
end
