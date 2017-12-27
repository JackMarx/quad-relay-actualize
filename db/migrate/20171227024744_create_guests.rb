class CreateGuests < ActiveRecord::Migration[5.1]
  def change
    create_table :guests do |t|
      t.string :first_name
      t.string :last_name
      t.integer :group_id
      t.date :start_date
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
