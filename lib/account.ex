defmodule Account do
  defstruct user: User, balance: 1000

  # inline method
  def create(user), do: %__MODULE__{user: user}


  defp get_user(accounts, account_user), do: Enum.find(accounts, fn account -> account.user.email == account_user.user.email end)
end
