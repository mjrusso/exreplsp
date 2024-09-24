defmodule NextLS.Evaluator do
  @moduledoc false
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def eval(node, code) do
    IO.puts(:stderr, "Evaluating code: #{code}")

    {result, updated_bindings} =
      :erpc.call(node, Code, :eval_string, [code, get()])

    IO.puts(:stderr, "Result: #{inspect(result, pretty: true)}")

    set(updated_bindings)

    result
  end

  defp get do
    Agent.get(__MODULE__, & &1)
  end

  defp set(value) do
    Agent.update(__MODULE__, fn _value -> value end)
  end
end
