defmodule CurrencyBot.Currency.Fetcher do
  alias CurrencyBot.Currency

  def start_link(init \\ true) do
    Task.start_link(fn ->
      update_store(init)
    end)
  end

  def update_store(init \\ true) do
    url = Application.get_env(:currency_bot, :currency_endpoint)
    resp = HTTPoison.get!(url)

    if resp.status_code != 200 do
      :logger.error("error while trying to fetch currency rates")
      nil
    else
      body = Jason.decode!(resp.body)

      if init do
        base_curr = body["base"]

        :logger.info("set base currency to #{base_curr}")
        Currency.Store.cast({:set_base, base_curr})
      end

      rates = Map.to_list(body["rates"])
      Currency.Store.cast({:update_many, rates})

      :logger.info("updated #{length(rates)} rates")

      rates
    end
  end
end
