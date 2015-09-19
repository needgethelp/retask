class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.integer :user_id      
      t.integer :task_id
      
      t.timestamps null: false
    end
  end
end
