class Transaction < ApplicationRecord
  validates_presence_of(:customer_id, :input_amount, :output_amount)
end
