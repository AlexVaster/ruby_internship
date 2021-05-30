class CreateBronies < ActiveRecord::Migration[6.1]
  def change
    create_table :bronies do |t|
      t.integer :id_ticket
      t.integer :number_brony
      t.time :time_broby

      t.timestamps
    end
  end
end
