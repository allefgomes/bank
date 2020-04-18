defmodule Transaction do
  defstruct created_at: Date.utc_today, type_transaction: nil, balance: 0, user_of: nil, user_to: nil

  @transactions_file "transactions.txt"
  def create(type_transaction, user_of, balance, user_to \\ nil) do
    transactions = search()

    transactions = transactions ++ [
      %__MODULE__{
        type_transaction: type_transaction,
        user_of: user_of,
        balance: balance,
        user_to: user_to,
        created_at: Date.utc_today
      }
    ]

    File.write(@transactions_file, :erlang.term_to_binary(transactions))
  end

  def find_all, do: search()

  defp search() do
    {:ok, binary} = File.read(@transactions_file)
    binary
    |> :erlang.binary_to_term
  end
end
