class UserPanelController < ApplicationController
  before_action :authenticate_user!
  def index
  end
  def profile
  end
  def view_invoice
    # @invoice = Stripe::Invoice.retrieve(params[:id])
    # @invoice = Stripe::Invoice.finalize_invoice(@invoice.id)
    # @invoice.send_invoice
    # @response = Stripe::Invoice.list(@invoice)
  end
end
