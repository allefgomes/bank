defmodule Account do
  defstruct user: User, balance: 1000

  @accounts_file "accounts.txt"
  # inline method
  def create(user) do
    # TODO: Check validate
    search_by_email(user.email)

    binary = [%__MODULE__{user: user}] ++ search()
    |> :erlang.term_to_binary

    File.write(@accounts_file, binary)
  end

  def search() do
    {:ok, binary} = File.read(@accounts_file)
    :erlang.binary_to_term(binary)
  end

  defp search_by_email(email) do
    Enum.find(
      search(),
      &(&1.user.email == email) # It's a anonimous function
      # fn account -> account.user.email == email end
    )
  end

  def transfer(account_of, account_to, value) do
    account_of = search_by_email(account_of.user.email)

    cond do
      validate_balance(account_of.balance, value) -> {:error, "Insufficient fundsto transfer!"}

      true ->
        account_to = search_by_email(account_to.user.email)

        account_of = %Account{account_of | balance: account_of.balance - value}
        account_to = %Account{account_to | balance: account_to.balance + value}

        [account_of, account_to]
    end
  end

  def withdraw(account, value) do
    cond do
      validate_balance(account.balance, value) -> {:error, "Insufficient funds to withdraw!"}

      true ->
        %Account{account | balance: account.balance - value}
    end
  end

  defp validate_balance(balance, value_to_transfer), do: balance < value_to_transfer
end
