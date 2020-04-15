defmodule Account do
  defstruct user: User, balance: 1000

  # inline method
  def create(user), do: %__MODULE__{user: user}

  def transfer(accounts, account_of, account_to, value) do
    account_of = get_user(accounts, account_of)

    cond do
      validate_balance(account_of.balance, value) -> {:error, "Insufficient fundsto transfer!"}

      true ->
        account_to = get_user(accounts, account_to)

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

  defp get_user(accounts, account_user), do: Enum.find(accounts, fn account -> account.user.email == account_user.user.email end)
end
