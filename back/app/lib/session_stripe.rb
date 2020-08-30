require 'stripe'

class SessionStripe
  Stripe.api_key = ENV['STRIPE_KEY']

  def self.get_checkout(user)
    # Create session for payment with Stripe Method. Then the front could redirect in stripe form to pay process.
    Stripe::Checkout::Session.create(payment_method_types: ['card'],
                                     line_items: [{ price: 'price_1HH8WLEfP5i1LDx8jZu9mHPl', quantity: 1 }],
                                     mode: 'subscription',
                                     metadata: { user_id: user.id },
                                     success_url: 'https://pli.hugovast.tech',
                                     cancel_url: 'https://pli.hugovast.tech')
  rescue Stripe::AuthenticationError
    nil
  end

  def self.confirm_order(req)
    # Stripe will use this method to confirm payment
    type = req['type']
    metadata = req['data']['object']['metadata']
    return unless type != 'checkout.session.completed'

    user = User.find(metadata['user_id'])
    user.set_premuim
  end


end