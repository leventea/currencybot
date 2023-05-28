defmodule CurrencyBotTest do
  use ExUnit.Case
  doctest CurrencyBot

  test "greets the world" do
    assert CurrencyBot.hello() == :world
  end
end
