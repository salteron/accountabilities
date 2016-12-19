class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.integer :role, null: false, index: true, default: 0
      t.timestamps null: false
    end
  end
end
