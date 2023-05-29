defmodule CurrencyBot do
  use Application

  def start(_type, _args) do
    sup = CurrencyBot.Supervisor.start_link()

    # start a poller task
    Task.Supervisor.start_child(
      CurrencyBot.Telegram.MessagePoller.Supervisor,
      &CurrencyBot.Telegram.MessagePoller.start_polling/0
    )

    sup
  end
end
