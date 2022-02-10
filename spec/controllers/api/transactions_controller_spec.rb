require 'rails_helper'

RSpec.describe Api::TransactionsController, type: :controller do
  describe 'GET #index' do
    subject { get :index, format: :json }

    it { should have_http_status(:success) }
  end

  describe 'GET #show' do
    subject { get :show, params: {id: 1}, format: :json }

    it { should have_http_status(:success) }
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
