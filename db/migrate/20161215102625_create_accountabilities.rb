class CreateAccountabilities < ActiveRecord::Migration
  def change
    create_table :accountabilities do |t|
      t.integer :role, null: false, index: true
      t.integer :child_id, null: false, index: true
      t.string :child_type, null: false, index: true
      t.integer :parent_id, null: false, index: true
      t.string :parent_type, null: false, index: true

      t.timestamps null: false
    end

    add_index :accountabilities,
      %i[child_id child_type parent_id parent_type],
      unique: true,
      name: 'index_accountabilities_on_parties'
  end
end
