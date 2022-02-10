class Api::TransactionsController < Api::ApiController
  def index
    render json: { data: Transaction.all }, status: :ok
  end

  def show
    transaction_id

    head :ok
  end

  def create
    transaction_params

    head :ok
  end

  private

  def transaction_id
    params.permit(:id)
  end

  def transaction_params
    params.require(:transaction).permit(
      :customer_id,
      :input_amount,
      :output_amount
    )
  end
end
