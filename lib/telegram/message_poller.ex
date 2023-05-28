defmodule CurrencyBot.Telegram.MessagePoller do
  def start_polling(offset \\ 0) do
    {:ok, updates} = Nadia.get_updates(offset: offset, timeout: 3600)

    :logger.debug("got #{length(updates)} updates")

    newest_offset = if length(updates) > 0 do
      List.last(updates).update_id + 1
    else
      offset
    end

    start_polling(newest_offset)
  end
end
