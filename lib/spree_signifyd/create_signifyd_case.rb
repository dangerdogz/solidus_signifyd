module SpreeSignifyd
  class CreateSignifydCase
    include Sidekiq::Worker

    @queue = :spree_backend_high

    def perform(order_number_or_id)
      Rails.logger.info "Processing Signifyd case creation event: #{order_number_or_id}"
      order = Spree::Order.find_by(number: order_number_or_id) || Spree::Order.find(order_number_or_id)
      order_data = JSON.parse(OrderSerializer.new(order).to_json)
      Signifyd::Case.create(order_data, SpreeSignifyd::Config[:api_key])
    end

  end
end
