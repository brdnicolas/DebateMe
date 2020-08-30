class StripeController < ApplicationController
  skip_before_action :authorize_request, only: [:webhook]

  # GET /payment/build
  def checkout
    # Create the session of the user in stripe for payement. There is the issue where the API keys are not in .env
    session = SessionStripe.get_checkout(current_user)
    code = session.nil? ? 422 : 200
    json_response session, code
  end

  # POST /payment/webhook
  def webhook
    # Stripe will use this POST endpoint to confirm payment
    post_data = request.body.read
    req = JSON.parse(post_data)
    json_response SessionStripe.confirm_order(req)
  end

end
