class RemoveTransactionsCurrenciesDefaults < ActiveRecord::Migration[7.0]
  def up
    change_column_default(:transactions, :input_currency, nil)
    change_column_default(:transactions, :output_currency, nil)
  end

  def down
    change_column_default(:transactions, :input_currency, '$')
    change_column_default(:transactions, :output_currency, '$')
  end
end
