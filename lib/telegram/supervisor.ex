defmodule CurrencyBot.Telegram.Supervisor do
  use Supervisor

  alias CurrencyBot.Telegram

  @impl true
  def init(_args \\ []) do
    children = [
      {
        Task.Supervisor,
        # there should only be a single poller process
        name: Telegram.MessagePoller.Supervisor, max_children: 1
      },
      Telegram.EventSource,
      Telegram.EventSink
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def start_link(args) do
    Supervisor.start_link(__MODULE__, args, name: __MODULE__)
  end
end
