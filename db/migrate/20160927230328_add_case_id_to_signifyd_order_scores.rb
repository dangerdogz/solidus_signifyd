class AddCaseIdToSignifydOrderScores < ActiveRecord::Migration
  def up
    add_column :spree_orders, :signifyd_case_id, :integer
  end

  def down
    remove_column :spree_orders, :signifyd_case_id
  end
end
