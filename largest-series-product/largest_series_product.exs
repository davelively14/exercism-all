defmodule Series do

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(_str, size) when size == 0, do: 1
  def largest_product(number_string, size) do
    {init_str, list, total} = init(number_string |> String.graphemes, size)
    largest_product(init_str, list, total)
  end
  def largest_product([], _list, total), do: total
  def largest_product([head | tail], list, total) do
    new_list = pop(list) ++ [head]
    new_total = get_total(new_list)
    cond do
      new_total > total ->
        largest_product(tail, new_list, new_total)
      true ->
        largest_product(tail, new_list, total)
    end
  end

  def init(str, size) when size > length(str), do: raise ArgumentError
  def init(_str, size) when size < 0, do: raise ArgumentError
  def init(str, counter), do: init(str, counter, [])
  def init(str, 0, list), do: {str, list |> Enum.reverse, list |> get_total}
  def init([head | tail], counter, list) do
    init(tail, counter - 1, [head | list])
  end

  def get_total(list) when length(list) > 0, do: get_total(list, 1)
  def get_total(_list), do: 0
  def get_total([], total), do: total
  def get_total([head | tail], total) do
    get_total(tail, total * String.to_integer(head))
  end

  def pop([_head | tail]), do: tail
end
