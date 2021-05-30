class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.integer :ticket_id
      t.string :fio
      t.integer :type
      t.boolean :status

      t.timestamps
    end
  end
end
