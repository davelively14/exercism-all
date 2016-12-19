defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns :error if it is not possible to compute the right amount of coins.
    Otherwise returns the tuple {:ok, map_of_coins}

    ## Examples

      iex> Change.generate(3, [5, 10, 15])
      :error

      iex> Change.generate(18, [1, 5, 10])
      {:ok, %{1 => 3, 5 => 1, 10 => 1}}

  """

  @spec generate(integer, list) :: {:ok, map} | :error
  def generate(amount, values) do
    result =
      make_change_map(values)
      |> get_results(amount)
    if result != :error do
      {:ok, Map.merge(make_change_map(values), result)}
    else
      :error
    end
  end

  def make_change_map(values), do: make_change_map(values, %{})
  def make_change_map([], map), do: map
  def make_change_map([head | tail], map), do: make_change_map(tail, Map.put_new(map, head, 0))

  def get_results(map, amount) do
    case result = get_results(Map.keys(map) |> Enum.reverse, amount, map) do
      :error ->
        if length(Map.keys(map)) > 0 do
          [_ | smaller_values] = Map.keys(map) |> Enum.reverse
          get_results(make_change_map(smaller_values), amount)
        else
          :error
        end
      _ ->
        result
    end
  end
  def get_results([], amount, result) do
    if amount == 0, do: result, else: :error
  end
  def get_results(values = [head | tail], amount, result) do
    if amount - head >= 0 do
      get_results(values, amount - head, Map.update!(result, head, &(&1 + 1)))
    else
      get_results(tail, amount, result)
    end
  end
end
