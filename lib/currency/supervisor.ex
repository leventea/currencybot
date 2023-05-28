defmodule CurrencyBot.Currency.Supervisor do
  use Supervisor

  alias CurrencyBot.Currency

  @impl true
  def init(_args) do
    children = [
      Currency.Store
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def start_link(_args) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end
end
