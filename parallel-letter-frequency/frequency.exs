defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency(texts, workers \\ 4), do: frequency(texts, workers, %{})
  def frequency([], _workers, result), do: result
  def frequency([head | tail], workers, result) do
    frequency(tail, workers, Task.async(__MODULE__, :letter_count, [head, result]) |> Task.await)
  end

  def letter_count(string), do: execute_letter_count(string |> String.graphemes, %{})
  def letter_count(string, map) when is_map(map), do: execute_letter_count(string |> String.graphemes, map)
  def execute_letter_count([], result), do: result
  def execute_letter_count([head | tail], result) do
    head = String.downcase(head)
    if head =~ ~r/\p{L}/ do
      case Map.has_key?(result, head) do
        true ->
          execute_letter_count(tail, Map.update!(result, head, &(&1 + 1)))
        _ ->
          execute_letter_count(tail, Map.put(result, head, 1))
      end
    else
      execute_letter_count(tail, result)
    end
  end
end
