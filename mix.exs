defmodule Diin.MixProject do
  use Mix.Project

  def project do
    [
      app: :diin,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      source_url: "https://github.com/alizain/diin",
      homepage_url: "https://github.com/alizain/diin",
      package: package(),
      deps: deps(),
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def description do
    "Direct dependency injection for elixir function"
  end

  defp package do
    [
      licenses: ["MIT"],
      maintainers: ["Alizain Feerasta (alizain.feerasta@gmail.com)"],
      links: %{
        "GitHub" => "https://github.com/alizain/diin"
      }
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.18.0", only: :dev}
    ]
  end
end
