defmodule CurrencyBot.Telegram.EventSource do
  use GenStage

  @type state :: any()

  # client impl
  def start_link(args \\ []) do
    GenStage.start_link(__MODULE__, args, name: __MODULE__)
  end

  def cast(request) do
    GenServer.cast(__MODULE__, request)
  end

  # server impl
  @impl true
  def init(_args \\ nil) do
    # unfulfilled demands is a list of tuple {pid, number_of_demands}
    {:producer, %{demands: []}}
  end

  @impl true
  def handle_demand(_demand, state) do
    {:noreply, [], state}
  end

  @impl true
  @spec handle_cast({:queue_events, list(any)}, state) :: {:noreply, list(any), state()}
  def handle_cast({:queue_events, events}, state) do
    {:noreply, events, state}
  end
end
