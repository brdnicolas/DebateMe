class StripeController < ApplicationController
  skip_before_action :authorize_request, only: [:webhook]

  # GET /payment/build
  def checkout
    json_response SessionStripe.get_checkout(current_user), 200
  end

  # POST /payment/webhook
  def webhook
    post_data = request.body.read
    req = JSON.parse(post_data)
    json_response SessionStripe.confirm_order(req)
  end

end
