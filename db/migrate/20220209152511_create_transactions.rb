class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :customer_id, null: false
      t.decimal :input_amount, null: false
      t.decimal :output_amount, null: false

      t.timestamps
    end
  end
end
