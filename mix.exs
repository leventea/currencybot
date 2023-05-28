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
      {:gen_stage, "~> 1.2.0"}, # used telegram event propagation
      {:nadia, "~> 0.7"}, # telegram lib
      {:jason, "~> 1.4"}, # used for parsing http responses
      {:quantum, "~> 3.5"}, # used for periodically refreshing currency rates
      {:tzdata, "~> 1.1"}, # Used by quantum for timezones
      {:httpoison, "~> 1.7"} # used for fetching currency rates, locked to 1.7 by nadia
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
