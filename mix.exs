defmodule CurrencyBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :currency_bot,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison],
      mod: {CurrencyBot, {}}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # used telegram event propagation
      {:gen_stage, "~> 1.2.0"},
      # telegram lib
      {:nadia, "~> 0.7"},
      # used for parsing http responses
      {:jason, "~> 1.4"},
      # used for periodically refreshing currency rates
      {:quantum, "~> 3.5"},
      # Used by quantum for timezones
      {:tzdata, "~> 1.1"},
      # used for fetching currency rates, locked to 1.7 by nadia
      {:httpoison, "~> 1.7"}
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
