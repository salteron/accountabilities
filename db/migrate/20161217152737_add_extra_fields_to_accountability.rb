class AddExtraFieldsToAccountability < ActiveRecord::Migration
  def change
    add_column :accountabilities, :is_active, :boolean, null: false, default: true
    add_column :accountabilities, :activated_at, :timestamp
  end
end
