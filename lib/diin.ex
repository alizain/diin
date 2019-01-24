defmodule Diin do
  @key :deps

  @doc """
  Uses first_write_wins strategy for merging opts
  """
  def parse(opts, config) when is_list(opts) and is_map(config) do
    opts
    |> Keyword.get_values(@key)
    |> Enum.reduce(%{}, fn
      curr_deps, all_deps when is_map(curr_deps) ->
        Map.merge(curr_deps, all_deps)

      curr_deps, _all_deps ->
        raise "#{inspect(@key)} must contain maps, given #{inspect(curr_deps)}"
    end)
    |> case do
      all_deps when all_deps == %{} ->
        config

      all_deps ->
        for {key, default_dep} <- config, into: %{} do
          case Map.fetch(all_deps, key) do
            {:ok, new_dep} ->
              case validate_dep(default_dep, new_dep) do
                :ok ->
                  {key, new_dep}

                :error ->
                  raise "Incompatible dep!"
              end

            :error ->
              {key, default_dep}
          end
        end
    end
  end

  defp validate_dep(default_dep, new_dep) when is_atom(default_dep) and not is_atom(new_dep) do
    :error
  end

  defp validate_dep(default_dep, new_dep) when is_atom(default_dep) and is_atom(new_dep) do
    :ok
  end

  defp validate_dep(default_dep, new_dep) when is_function(default_dep) and not is_function(new_dep) do
    :error
  end

  defp validate_dep(default_dep, new_dep) when is_function(default_dep) and is_function(new_dep) do
    if :erlang.fun_info(default_dep)[:arity] == :erlang.fun_info(new_dep)[:arity] do
      :ok
    else
      :error
    end
  end

  defp validate_dep(_default_dep, _new_dep) do
    :ok
  end
end
