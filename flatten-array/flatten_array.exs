defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list), do: flatten(list, []) |> Enum.reverse
  def flatten([], result), do: result
  def flatten([head | tail], result) do
    cond do
      is_list(head) -> flatten(tail, flatten(head, result))
      head -> flatten(tail, [head | result])
      true -> flatten(tail, result)
    end
  end
end
