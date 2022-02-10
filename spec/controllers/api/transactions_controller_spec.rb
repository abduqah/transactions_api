require 'rails_helper'

RSpec.describe Api::TransactionsController, type: :controller do
  describe 'GET #index' do
    subject { get :index, format: :json }

    it { should have_http_status(:success) }

    context 'Show system data' do
      it 'gets existing data' do
        should have_http_status(:success)

        body = JSON.parse(response.body)

        expect(body['data'].size).to eq(2)
      end
    end
  end

  describe 'GET #show' do
    before { @transaction = Transaction.first }

    subject { get :show, params: {id: @transaction.id}, format: :json }

    it { should have_http_status(:success) }

    it 'gets transaction with given id' do
      should have_http_status(:success)

      body = JSON.parse(response.body)

      expect(body['data'].size).to be_truthy
      expect(body['data']['customer_id']).to eq(@transaction.customer_id)
    end

    it 'return not found for non existing transactions' do
      get :show, params: {id: 0}, format: :json

      expect(response.code).to eq("404")

      body = response.body

      expect(body).to be_empty
    end
  end

  describe 'POST #create' do
    params = {
      transaction: {
        customer_id: 1,
        input_amount: 321,
        output_amount: 321
      }
    }

    subject { post :create, params: params, format: :json }

    it { should have_http_status(:success) }
    it { should permit(:customer_id, :input_amount, :output_amount).
                 for(:create, params: params).
                 on(:transaction) }
  end
end
