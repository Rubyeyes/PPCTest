class AddUnconfirmabledEmailToDevise < ActiveRecord::Migration
  # Note: You can't use change, as User.update_all will fail in the down migration
  def up
    add_column :users, :unconfirmed_email, :string
  end
end
