defmodule CurrencyBot.Telegram.MessageHandler do
  def start_link(event) do
    Task.start_link(fn ->
      handle_message(event)
    end)
  end

  defp handle_message(_event) do
    :logger.debug("handling event")
  end
end
