Spree::OrderContents.class_eval do

  def approve(user: nil, name: nil)
    if user.blank? && name.blank?
      raise ArgumentError, 'user or name must be specified'
    end

    order.update_attributes!(
        approver: user,
        approver_name: name,
        approved_at: Time.current,
    )
  end
end