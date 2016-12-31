defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  def encode(""), do: ""
  def encode(str) do
    str = str |> String.downcase |> String.graphemes |> Enum.filter(&(&1 =~ ~r/[0-9a-z]/))
    length = str |> length
    cond do
      rem((:math.sqrt(length) * 10) |> round, 10) == 0 ->
        square(str, length |> :math.sqrt |> round)
      true ->
        non_square(str, length |> :math.sqrt |> Float.ceil |> round)
    end
  end

  def non_square(str, c), do: non_square(str, c, rem(length(str), c), init_map(c))
  def non_square([], _c, _tracker, result), do: result |> to_square
  def non_square(str, c, tracker, result) do
    case tracker > 0 do
      true ->
        {next_str, new_map} = put_chunk(str, c, result)
        non_square(next_str, c, tracker - 1, new_map)
      false ->
        {next_str, new_map} = put_chunk(str, c - 1, result)
        non_square(next_str, c, tracker, new_map)
    end
  end

  def square(str, c), do: square(str, c, init_map(c))
  def square([], _c, result), do: result |> to_square
  def square(str, c, result) do
    {next_str, new_map} = put_chunk(str, c, result)
    square(next_str, c, new_map)
  end

  def put_chunk(list, max, result), do: put_chunk(list, max, result, 1)
  def put_chunk([], _max, result, _counter), do: {[], result}
  def put_chunk(list, max, result, counter) when counter > max, do: {list, result}
  def put_chunk([head | tail], max, result, counter) do
    put_chunk(tail, max, Map.update!(result, counter, &(&1 <> head)), counter + 1)
  end

  def init_map(counter), do: init_map(counter, %{})
  def init_map(0, map), do: map
  def init_map(counter, map), do: init_map(counter - 1, Map.put(map, counter, ""))

  def to_square(map), do: to_square(map, Map.keys(map), "")
  def to_square(_map, [], result), do: result |> String.lstrip
  def to_square(map, [head | tail], result) do
    to_square(map, tail, result <> " " <> Map.get(map, head))
  end
end
