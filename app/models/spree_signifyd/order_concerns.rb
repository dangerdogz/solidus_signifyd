module SpreeSignifyd::OrderConcerns
  extend ActiveSupport::Concern

  included do

    insert_checkout_step :selection, :before => :address

    self.state_machine.after_transition to: :complete, :do => :create_case, unless: :approved?

    has_one :signifyd_order_score, class_name: "SpreeSignifyd::OrderScore"

    def create_case
      SpreeSignifyd.create_case(order_number: self.number)
    end

    prepend(InstanceMethods)
  end

  module InstanceMethods
    def is_risky?
      !(awaiting_approval? || approved?)
    end

    def awaiting_approval?
      !signifyd_order_score
    end
  end
end
