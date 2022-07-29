class AddEmailToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.column :email, :string
    end
  end
end
