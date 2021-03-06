defmodule ImopiCrawler.Mixfile do
  use Mix.Project

  def project do
    [app: :imopi_crawler,
     version: "0.1.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps(),
     test_coverage: [tool: Coverex.Task]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:floki, "~> 0.11.0"},
      {:coverex, "~> 1.4.10", only: :test},
      {:exvcr, "~> 0.7", only: :test},
      {:httpoison, "~> 0.10.0"}
    ]
  end
end
