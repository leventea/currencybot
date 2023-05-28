defmodule CurrencyBot.Supervisor do
  use Supervisor

  @impl true
  def init(_args \\ []) do
    children = [
      CurrencyBot.Scheduler,
      CurrencyBot.Telegram.Supervisor,
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def start_link(_init \\ []) do
    Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end
end
