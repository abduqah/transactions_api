class Api::TransactionsController < Api::ApiController
  def index
    render json: { data: Transaction.all }, status: :ok
  end

  def show
    transaction = Transaction.find_by_id(transaction_id[:id])

    return head :not_found unless transaction

    render json: { data: transaction }, status: :ok
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
