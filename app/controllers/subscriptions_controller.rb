class SubscriptionsController < ApplicationController
  before_action :authenticate_user! , except: [:stripe_checkout, :pay_with_paypal]
  require "stripe"

  def create
  end

  def index
  end

  def plans
  end

  def stripe_checkout
    @amount = params[:amount].present? ? params[:amount].to_i : 10
    #This will create a charge with stripe for $10
    #Save this charge in your DB for future reference
    charge = Stripe::Charge.create(
        :amount => @amount * 100,
        :currency => "usd",
        :source => params[:stripeToken],
        :description => "Test Charge"
    )
    flash[:notice] = "Successfully accepted a donation of $#{@amount}"
    redirect_to feeds_path
  end

  def pay_with_paypal
    @amount = params[:amount].present? ? params[:amount].to_i : 10
    total_amount = @amount * 100
    response = EXPRESS_GATEWAY.setup_purchase(total_amount,
                                              ip: request.remote_ip,
                                              return_url: feeds_url,
                                              cancel_return_url: feeds_url,
                                              currency: "USD",
                                              allow_guest_checkout: true,
                                              items: [{name: "Donation", description: "Donation to Feedit", quantity: "1", amount: total_amount}]
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end


end
