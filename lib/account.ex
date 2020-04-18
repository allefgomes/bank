defmodule Account do
  defstruct user: User, balance: 1000

  @accounts_file "accounts.txt"

  def create(user) do
    case search_by_email(user.email) do
      nil ->
        binary = [%__MODULE__{user: user}] ++ search()
        |> :erlang.term_to_binary
        File.write(@accounts_file, binary)
      _ -> {:error, "there is already a registration with the email used!"}
    end
  end

  def search() do
    {:ok, binary} = File.read(@accounts_file)
    :erlang.binary_to_term(binary)
  end

  defp search_by_email(email) do
    Enum.find(
      search(),
      &(&1.user.email == email) # It's a anonymous function
      # fn account -> account.user.email == email end
    )
  end

  def transfer(account_of, account_to, value) do
    account_of = search_by_email(account_of.user.email)

    cond do
      validate_balance(account_of.balance, value) -> {:error, "Insufficient fundsto transfer!"}

      true ->
        accounts = search()

        accounts = List.delete accounts, account_of
        accounts = List.delete accounts, account_to

        account_of = %Account{account_of | balance: account_of.balance - value}
        account_to = %Account{account_to | balance: account_to.balance + value}

        accounts = accounts ++ [account_of, account_to]
                  |> :erlang.term_to_binary

        File.write(@accounts_file, accounts)
    end
  end

  def withdraw(account, value) do
    cond do
      validate_balance(account.balance, value) -> {:error, "Insufficient funds to withdraw!"}

      true ->
        accounts = search()
        accounts = List.delete(accounts, account)

        account = %Account{account | balance: account.balance - value}
        accounts = accounts ++ [account]
                  |> :erlang.term_to_binary

        File.write(@accounts_file, accounts)
    end
  end

  defp validate_balance(balance, value_to_transfer), do: balance < value_to_transfer
end
