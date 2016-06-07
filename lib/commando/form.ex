defmodule Commando.Form do
  defmacro __using__(_opts) do
    quote do
      use Vex.Struct
      use ExConstructor

      import Vex, only: [valid?: 1]

      def to_map(form) do
        Map.from_struct(form)
      end

      def to_map(form, [except: list]) do
        to_map(form)
        |> remove_map_keys(list)
      end

      defp remove_map_keys(map, []) do
        map
      end

      defp remove_map_keys(map, [h | t]) do
        map
        |> Map.delete(h)
        |> remove_map_keys(t)
      end

      def errors(form) do
        map = Map.keys(form) |> Enum.filter(&(&1 != :__struct__)) |> Enum.map(&({&1, []})) |> Enum.into(%{})

        results = form |> Vex.results(Vex.Extract.settings(form))

        {_, map} = Enum.map_reduce(results, map, fn(x, acc) -> {nil, %{acc | elem(x, 1) => add_error(acc[elem(x,1)], x)}} end)
        map
      end

      defp add_error(field_errors, {:ok, _, _}) do
        field_errors
      end

      defp add_error(field_errors, {:error, field, _, error}) when is_bitstring(error) do
        [error | field_errors]
      end

      defp add_error(field_errors, {:error, field, _, error}) do
        [convert_vars(Enum.into(error, %{})) | field_errors]
      end

      defp add_error(field_errors, {:not_applicable, _, _}) do
        field_errors
      end

      defp convert_vars(error_map) do
        %{ error_map | :vars => Enum.into(error_map[:vars], %{}) }
      end
    end
  end
end

