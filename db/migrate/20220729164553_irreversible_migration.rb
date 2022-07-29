class IrreversibleMigration < ActiveRecord::Migration[7.0]
  def up
    User.create(
      name: "useradmin",
      password: BCrypt::Password.create("password"),
      email: "useradmin@useradmin.com"
    )
  end

  def down
    raise ActiveRecord::IrreversibleMigration, "Cannot Rollback Migration #{self.class}"

    # User.destroy(name: "useradmin")
  end
end
