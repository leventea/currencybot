defmodule CurrencyBot.Telegram.MessagePoller do
  alias CurrencyBot.Telegram

  def start_polling(offset \\ 0) do
    # TODO: add error handling here
    {:ok, updates} = Nadia.get_updates(offset: offset, timeout: 60 * 60)

    :logger.debug("got #{length(updates)} updates")

    newest_offset =
      if length(updates) > 0 do
        # dispatch the new events to the event source
        Telegram.EventSource.cast({:queue_events, updates})

        List.last(updates).update_id + 1
      else
        offset
      end

    start_polling(newest_offset)
  end
end
