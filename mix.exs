defmodule ExchemaExtra.MixProject do
  use Mix.Project

  def project do
    [
      app: :exchema_extra,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:exchema, "~> 0.4.0"},
      {:uuid, "~> 1.1", optional: true},
      {:exchema_coercion, github: "bamorim/exchema_coercion", optional: true},
      {:exchema_stream_data, github: "bamorim/exchema_stream_data", optional: true},
      {:brcpfcnpj, "~> 0.1.0"}
    ]
  end
end
