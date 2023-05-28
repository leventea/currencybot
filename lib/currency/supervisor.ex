defmodule CurrencyBot.Currency.Supervisor do
  use Supervisor

  alias CurrencyBot.Currency

  @impl true
  def init(_args) do
    children = [
      Currency.Store
    ]

    res = Supervisor.init(children, strategy: :one_for_one)

    # fetch the exchange rates and store them in Currency.Store
    Currency.Fetcher.start_link()

    res
  end

  def start_link(_args) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end
end
