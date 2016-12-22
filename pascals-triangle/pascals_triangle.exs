defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num), do: rows(num, [[1]])
  def rows(1, result), do: result |> Enum.reverse
  def rows(num, result = [last_row | _tail]) do
    row = get_next_row(last_row)
    rows(num - 1, [row | result])
  end

  defp get_next_row(last_row), do: get_next_row(last_row, [1])
  defp get_next_row([head | tail], result) when length(tail) == 0, do: [1 | result] |> Enum.reverse
  defp get_next_row([head | tail], result) do
    get_next_row(tail, [head + (List.first(tail)) | result])
  end
end
