require 'rails_helper'

RSpec.describe Api::TransactionsController, type: :controller do
  before do
    params = {
      customer_id: 1,
      input_amount: 321,
      output_amount: 321,
      input_currency: '$',
      output_currency: '$'
    }

    Transaction.create!(params)
    params[:customer_id] = 2
    params[:input_currency] = '€'
    params[:output_currency] = '€'
    Transaction.create!(params)
  end

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
      expect(body['data']['input_amount'].to_f).to eq(@transaction.input_amount)
    end

    it 'return not found for non existing transactions' do
      get :show, params: {id: 0}, format: :json

      expect(response.code).to eq("404")

      body = response.body

      expect(body).to be_empty
    end
  end

  describe 'POST #create' do
    let(:params) {
      {
        transaction: {
          customer_id: 1,
          input_amount: 321,
          output_amount: 321,
          input_currency: '$',
          output_currency: '$'
        }
      }
    }

    subject { post :create, params: params, format: :json }

    it { should have_http_status(:success) }
    it { should permit(:customer_id, :input_amount, :output_amount, :input_currency, :output_currency).
                 for(:create, params: params).
                 on(:transaction) }

    context 'create transactions' do
      it 'create a transaction and return it' do
        post :create, params: params, format: :json

        expect(response.code).to eq("200")

        body = JSON.parse(response.body)
        transaction = body['data']

        expect(body['data']['id']).not_to be_nil
        expect(body['data']['customer_id'].to_f).to eq(params[:transaction][:customer_id])
        expect(body['data']['input_amount'].to_f).to eq(params[:transaction][:input_amount])
        expect(body['data']['output_amount'].to_f).to eq(params[:transaction][:output_amount])
      end

      it 'return issues if creation not succeed' do
        params[:transaction].delete(:customer_id)

        post :create, params: params, format: :json

        expect(response.code).to eq("422")

        body = JSON.parse(response.body)
        errors = body['errors']

        expect(errors).not_to be_empty
        expect(errors['customer_id']).to eq(["can't be blank"])
      end
    end
  end

  describe 'PUT #update' do
    let(:transaction_1) {
      Transaction.first
    }

    let!(:transaction_1_id) {
      transaction_1.id
    }

    let!(:params) {
      {
        id: transaction_1_id,
        transaction: {
          customer_id: 123
        }
      }
    }
    

    it 'update the first transaction with the new params' do
      put :update, params: params, format: :json

      expect(response.code).to eq('200')
      data = JSON.parse(response.body)
      expect(data['data']['id']).to eq(transaction_1_id)
      expect(data['data']['customer_id']).to eq(params[:transaction][:customer_id])
    end

    it 'not allow updating with empty values' do
      params[:transaction][:customer_id] = nil

      put :update, params: params, format: :json

      expect(response.code).to eq('422')
      
      data = JSON.parse(response.body)

      expect(data['errors']).not_to be_empty
    end
  end
end
