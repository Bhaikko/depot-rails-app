class ChangeDefaultOfEnabledOfProducts < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :enabled, :boolean, default: false
  end
end
