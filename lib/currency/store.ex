defmodule CurrencyBot.Currency.Store do
  use GenServer

  @type currency_value() :: {String.t(), float()}
  @type state() :: %{table: :ets.table(), base: String.t() | nil}

  # server impl

  @impl true
  def init(_args) do
    table = :ets.new(:currency_rates, [:protected, :set])
    {:ok, %{table: table, base: nil}}
  end

  @impl true
  @spec handle_cast({:update, String.t(), float()}, state()) :: {:noreply, state()}
  def handle_cast({:update, curr, value}, state = %{table: table}) do
    :ets.insert(table, {curr, value})

    {:noreply, state}
  end

  def handle_cast({:update_many, list}, state = %{table: table}) do
    :ets.insert(table, list)

    {:noreply, state}
  end

  @impl true
  def handle_cast({:set_base, curr}, state) do
    {:noreply, Map.put(state, :base, curr)}
  end

  # client impl

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def cast(req) do
    GenServer.cast(__MODULE__, req)
  end
end
