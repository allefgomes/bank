defmodule User do
  defstruct name: nil, email: nil

  def new(name, email) do
    # if it is a module, can change User to __MODULE__
    # %User{name: name, email: email}

    %__MODULE__{name: name, email: email}
  end
end
