class AddCurrenciesToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :input_currency, :string, null: false, default: '$'
    add_column :transactions, :output_currency, :string, null: false, default: '$'
  end
end
