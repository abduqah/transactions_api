require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'validations' do
    it { should validate_presence_of :customer_id }
    it { should validate_presence_of :input_amount }
    it { should validate_presence_of :output_amount }
  end
end
