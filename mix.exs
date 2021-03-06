defmodule Medera.Mixfile do
  use Mix.Project

  def project do
    [app: :medera,
     version: "0.1.0",
     elixir: "~> 1.3",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     test_coverage: [tool: ExCoveralls],
     preferred_cli_env: [coveralls: :test],
     dialyzer: [
       # tells dialyzer to load all dependency applications (avoid warningss
       # about functions/types that are defined in dependencies)
       plt_add_deps: :transitive,
       # we also need the mix app so that dialyzer can analyze our mix tasks
       plt_add_apps: [:mix]
     ],
     aliases: aliases(),
     deps: deps(),
     docs: [main: "README", # The main page in the docs
            extras: ["README.md"]]]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Medera, []},
     applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :postgrex, :slack]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.2.1"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_ecto, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:phoenix_html, "~> 2.6"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},
      {:credo, "~> 0.5", only: [:dev, :test]},
      {:patiently, "~> 0.1", only: [:test]},
      {:slack, "~> 0.9.0"},
      {:ex_doc, "~> 0.14.5", only: [:dev]},
      {:excoveralls, "~> 0.6.1", only: [:test]},
      {:dialyxir, "~> 0.4.3", only: [:dev]}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
