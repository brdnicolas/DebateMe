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
    type = req['type']
    metadata = req['data']['object']['lines']['data'][0]['metadata']
    if type == 'invoice.upcoming'
      user = User.find(metadata['user_id'])
      user.update!(isPremuim: true)
      json_response 'done'
    end
  end

end
