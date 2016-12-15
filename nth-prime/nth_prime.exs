defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0, do: nth(count, [3, 2], 5)
  def nth(count, _results, _counter) when count == 0, do: 0
  def nth(count, _results, _counter) when count == 1, do: 2
  def nth(count, results, _counter) when count == length(results), do: results |> List.first
  def nth(count, results, counter) do
    if is_prime?(counter) do
      IO.inspect counter
      nth(count, [counter | results], counter + 2)
    else
      nth(count, results, counter + 2)
    end
  end

  def is_prime?(num) when num < 2, do: false
  def is_prime?(num) when num == 2, do: true
  def is_prime?(num) when num == 3, do: true
  def is_prime?(num) when rem(num, 2) == 0, do: false
  def is_prime?(num) when rem(num, 3) == 0, do: false
  # def is_prime?(num) when num > , do: is_prime?(num, div(num, 2))
  def is_prime?(num), do: is_prime?(num, num - 1)
  def is_prime?(_num, 4), do: true
  def is_prime?(num, counter) when rem(num, counter) == 0, do: false
  def is_prime?(num, counter), do: is_prime?(num, counter - 1)

  # def is_prime?(num) do
  #   for i <- 5..div(num, 2) do
  #
  #     if rem(num, i) do
  #       false
  #     end
  #   end
  # end
  #
  #
  # def is_prime?(num), do: is_prime?(num, [5..div(num, 2)])
  # def is_prime?(_num, []), do: true
  # def is_prime?(num)
end
