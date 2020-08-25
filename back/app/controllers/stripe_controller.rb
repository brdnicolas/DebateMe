class StripeController < ApplicationController
  skip_before_action :authorize_request, only: [:webhook]

  # GET /payment/build
  def checkout
    json_response SessionStripe.get_checkout(current_user), 200
  end

  # POST /payment/webhook
  def webhook
    type = req.body.type
    data = req.body
    puts data
    puts type
  end

end
