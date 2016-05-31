defmodule Commando.Command do
  defmacro __using__(options) do
    quote do
      alias __MODULE__.Form
    end
  end
end

