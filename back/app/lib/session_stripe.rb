require 'stripe'

class SessionStripe
  Stripe.api_key = ENV['STRIPE_KEY']

  def self.get_checkout(user)
    Stripe::Checkout::Session.create(payment_method_types: ['card'],
                                     line_items: [{ price: 'price_1HH8WLEfP5i1LDx8jZu9mHPl', quantity: 1 }],
                                     mode: 'subscription',
                                     metadata: { user_id: user.id },
                                     success_url: 'https://pli.hugovast.tech',
                                     cancel_url: 'https://pli.hugovast.tech')
  end


end