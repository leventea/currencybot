defmodule CurrencyBot.Supervisor do
  use Supervisor

  @impl true
  def init(_args \\ []) do
    children = [
      CurrencyBot.Scheduler,
      { Task.Supervisor,
        name: CurrencyBot.Telegram.MessagePoller.Supervisor,
        max_children: 1 } # there should only be a single poller process
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def start_link(_init \\ []) do
    Supervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end
end
