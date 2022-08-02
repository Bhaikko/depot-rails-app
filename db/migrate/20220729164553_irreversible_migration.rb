class IrreversibleMigration < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :name, :text

    ## To create above changes reversible
    # reversible do |dir|
    #   dir.up do
    #     change_column :users, :name, :string
    #   end

    #   dir.down do
    #     change_column :users, :name, :string
    #   end
    # end
  end
end
