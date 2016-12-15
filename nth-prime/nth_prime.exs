defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0, do: nth(count, [3, 2], 5)
  def nth(count, _results, _counter) when count == 0, do: 0
  def nth(count, _results, _counter) when count == 1, do: 2
  def nth(count, _results, _counter) when count == 2, do: 3
  def nth(count, results, _counter) when count == length(results), do: results |> List.first
  def nth(count, results, counter) do
    if is_prime?(counter, results) do
      nth(count, [counter | results], counter + 2)
    else
      nth(count, results, counter + 2)
    end
  end

  def is_prime?(num, _results) when num < 2, do: false
  def is_prime?(num, _results) when num == 2, do: true
  def is_prime?(num, _results) when num == 3, do: true
  def is_prime?(num, _results) when rem(num, 2) == 0, do: false
  def is_prime?(num, _results) when rem(num, 3) == 0, do: false
  def is_prime?(_num, []), do: true
  def is_prime?(num, [head | tail]) do
    for counter <- 5..num  do
      if rem(num, counter) == 0 || rem(num, head) == 0 do
        false
      end
    end
    is_prime?(num, tail)
  end
end
