defmodule Account do
  defstruct user: User, balance: 1000

  # inline method
  def create(user), do: %__MODULE__{user: user}
end
