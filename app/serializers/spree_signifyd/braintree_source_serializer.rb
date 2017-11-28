require 'active_model/serializer'

module SpreeSignifyd
  class BraintreeSourceSerializer < ActiveModel::Serializer
    self.root = false

    attributes :cardHolderName, :last4

    # this is how to conditionally include attributes in AMS
    def attributes(*args)
      hash = super
      hash[:expiryMonth] = object.expiration_month.to_i if object.expiration_month
      hash[:expiryYear] = object.expiration_year.to_i if object.expiration_year
      hash
    end

    def cardHolderName
      object.cardholder_name
    end

    def last4
      object.last_4
    end
  end
end
