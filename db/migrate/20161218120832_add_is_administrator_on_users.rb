class AddIsAdministratorOnUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_administator, :boolean, null: false, default: false
  end
end
