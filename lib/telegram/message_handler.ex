defmodule CurrencyBot.Telegram.MessageHandler do
  def start_link(event) do
    Task.start_link(fn ->
      handle_message(event)
    end)
  end

  defp extract_text(event) do
    case event.message do
      nil -> nil
      %{text: text, caption: caption} -> text || caption
    end
  end

  defp handle_message(event) do
    IO.inspect(event)
    :logger.debug("text: #{extract_text(event)}")
  end
end
