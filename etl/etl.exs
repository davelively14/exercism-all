defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    keys = Map.keys(input)
    transform(keys, input, %{})
  end
  def transform([], _input, new_map), do: new_map
  def transform([head | tail], input, new_map) do
    transform(tail, input, insert_new_values(Map.get(input, head), head, new_map))
  end

  defp insert_new_values([], _value, new_map), do: new_map
  defp insert_new_values([head | tail], value, new_map) do
    insert_new_values(tail, value, Map.put(new_map, String.downcase(head), value))
  end
end
