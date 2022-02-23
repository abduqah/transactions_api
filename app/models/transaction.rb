class Transaction < ApplicationRecord
  validates_presence_of(:customer_id, :input_amount, :output_amount, :input_currency, :output_currency)

  validates :input_amount, :output_amount, numericality: { greater_than: 1 }
end
