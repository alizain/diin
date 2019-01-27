# Diin

[![Master](https://img.shields.io/circleci/project/github/alizain/diin/master.svg)](https://circleci.com/gh/alizain/diin)
[![Hex.pm Version](https://img.shields.io/hexpm/v/diin.svg)](https://hex.pm/packages/diin)

Diin is a simple convenience wrapper for directly injecting dependencies into Elixir functions.
- [Documentation](https://hexdocs.pm/diin)

## Installation

Add `diin` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:diin, "~> 0.1.0"}
  ]
end
```


## Usage

```elixir
def get_object(id, opts \\ []) do
  # Define the default dependencies this function uses to do it's work
  deps = Diin.parse(opts, %{http: HTTPoison})
  # Use dependencies to do work
  deps.http.get!("https://foo.bar/#{id}")
end

# Now you can easily change dependencies when calling the function
get_object(1, deps: %{http: TestHTTPClient})
```

Things get more interesting when you pass dependencies to nested functions.

```elixir
def nested_do_work(raw, opts \\ []) do
  # Set the default HTML parser function
  deps = Diin.parse(opts, %{
    html_parser: &MochiWeb.parse/1,
    transformer: fn val -> val end,
  })
  # Do the deed
  raw
  |> deps.html_parser.()
  |> deps.transformer.()
end

def do_work(raw, opts \\ []) do
  # Change some dependencies
  opts =
    [deps: %{transformer: &do_transformation/1}] ++ opts
  # Now, `nested_do_work` will use the transformer function passed above instead of the default one.
  nested_do_work(raw, opts)
end

# Passing in a different dependency for `html_parser` still works!
do_work(raw, deps: %{html_parser: &Html5Ever.parse/1})
```
