defmodule Transaction do
  defstruct created_at: Date.utc_today(),
            type_transaction: nil,
            balance: 0,
            user_of: nil,
            user_to: nil

  @transactions_file "transactions.txt"
  def create(type_transaction, user_of, balance, user_to \\ nil) do
    transactions = search()

    transactions =
      transactions ++
        [
          %__MODULE__{
            type_transaction: type_transaction,
            user_of: user_of,
            balance: balance,
            user_to: user_to,
            created_at: Date.utc_today() |> Date.add(5)
          }
        ]

    File.write(@transactions_file, :erlang.term_to_binary(transactions))
  end

  def all, do: search()

  def by_year(year), do: Enum.filter(all(), &(&1.created_at.year == year))

  def by_month(year, month),
    do: Enum.filter(all(), &(&1.created_at.month == month && &1.created_at.year == year))

  def by_day(day), do: Enum.filter(all(), &(&1.created_at == day))

  def calculate_total_month(year, month), do: calculate(by_month(year, month))

  def calculate_total_year(year), do: calculate(by_year(year))

  def calculate_total_day(day), do: calculate(by_day(day))

  def calculate(transactions) do
    total_transferred = Enum.reduce(transactions, 0, fn x, acc -> acc + x.balance end)

    %{total_transferred: total_transferred, transactions: Enum.count(transactions)}
  end

  def calculate(), do: all() |> calculate()

  defp search() do
    {:ok, binary} = File.read(@transactions_file)

    binary
    |> :erlang.binary_to_term()
  end
end
