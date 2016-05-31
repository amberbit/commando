defmodule Commando.Mixfile do
  use Mix.Project

  def project do
    [app: :commando,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     consolidate_protocols: Mix.env != :test,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
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
      {:exconstructor, "~> 1.0.2"},
      {:vex, "~> 0.5.5"},
      {:plug, "~> 1.1.4"},
      {:poison, "~> 2.0.1"},
    ]
  end
end
