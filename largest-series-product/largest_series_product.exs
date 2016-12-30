defmodule Series do

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
    {init_str, list} = init(number_string |> String.graphemes, size)
    largest_product(init_str, list, 0)
  end
  def largest_product([], _list, total), do: total
  def largest_product([head | tail], list, total) do
    nil
  end

  def init(str, size) when size > length(str), do: raise ArgumentError
  def init(str, size) when size < 0, do: raise ArgumentError
  def init(str, counter), do: init(str, counter, [])
  def init(str, 0, list), do: {str, list |> Enum.reverse}
  def init([head | tail], counter, list) do
    init(tail, counter - 1, [head | list])
  end
end
