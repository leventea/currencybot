defmodule CurrencyBot.Telegram.EventSink do
  use ConsumerSupervisor

  alias CurrencyBot.Telegram, as: TG

  def start_link(_args \\ []) do
    ConsumerSupervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @impl true
  def init(_args) do
    children = [
      %{id: TG.MessageHandler, start: {TG.MessageHandler, :start_link, []}, restart: :transient}
    ]

    max_demand = Application.get_env(:currency_bot, :max_demand, 20)

    ConsumerSupervisor.init(children,
      strategy: :one_for_one,
      subscribe_to: [{TG.EventSource, max_demand: max_demand}]
    )
  end
end
