defmodule CurrencyBot.Currency.Exchange do
  alias CurrencyBot.Currency

  import Enum, only: [map: 2]

  @spec convert(float(), String.t(), list(String.t())) :: list({String.t(), float()})
  def convert(amount, from, target_currencies) do
    # REVIEW: bottleneck?
    table = Currency.Store.call({:get_table})

    [{^from, source_rate}] = :ets.lookup(table, from)

    target_currencies
    |> map(fn curr -> :ets.lookup(table, curr) end)
    |> map(fn [w] -> w end) # unwrap from extra array
    |> map(fn {curr, val} ->
      single = val / source_rate # worth of 1 unit of target currency
      {curr, amount * single}
    end)
  end
end
