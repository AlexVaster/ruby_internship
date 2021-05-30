class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.integer :ticket_id
      t.integer :ticket_category
      t.datetime :data
      t.integer :status
      t.string :fio

      t.timestamps
    end
  end
end
