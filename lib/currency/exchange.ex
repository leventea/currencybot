defmodule CurrencyBot.Currency.Exchange do
  alias CurrencyBot.Currency

  import Enum, only: [map: 2, filter: 2]

  @spec convert(float(), String.t(), list(String.t()), integer()) :: {:ok, list({String.t(), float()})} | {:err, String.t()}
  def convert(amount, from, target_currencies, round_to \\ 2) do
    # REVIEW: bottleneck?
    table = Currency.Store.call({:get_table})

    case :ets.lookup(table, from) do
      [] -> {:err, "invalid source currency"}
      [{^from, source_rate}] -> {:ok,
      target_currencies
      |> map(fn curr -> :ets.lookup(table, curr) end)
      |> filter(fn x -> x != [] end) # filter out invalid lookup results
      |> map(fn [w] -> w end) # unwrap from extra list
      |> map(fn {curr, val} ->
        single = val / source_rate # worth of 1 unit of target currency
        rounded = round_to(amount * single, round_to)
        {curr, rounded}
      end)}
    end
  end

  @spec round_to(float(), integer()) :: float()
  defp round_to(amount, decimals) do
    coeff = Float.pow(10.0, decimals)
    Float.round(amount * coeff) / coeff
  end
end
