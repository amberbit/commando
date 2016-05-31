defmodule Commando.TestCommand.Form do
  defstruct field: nil

  use Commando.Form

  validates :field, presence: true
end

defmodule Commando.TestCommand do
  use Commando.Command

  def execute(args, _env \\ %{}) do
    form = Form.new(args)

    if Form.valid?(form) do
      :ok
    else
      {:error, Form.errors(form)}
    end
  end
end

defmodule Commando.CommandTest do
  use ExUnit.Case
  alias Commando.TestCommand

  test "can be initialized with string-based parameters" do
    :ok = TestCommand.execute(%{"field" => "hello"})
  end

  test "can be initialized with atom-based parameters" do
    :ok = TestCommand.execute(%{field: "hello"})
  end

  test "performs validations and returns errors" do
    {:error, errors} = TestCommand.execute(%{field: nil})
    assert errors == %{field: ["must be present"]}
    {:error, errors} = TestCommand.execute(%{})
    assert errors == %{field: ["must be present"]}
  end
end

