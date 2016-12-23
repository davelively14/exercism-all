defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) when number < 2, do: []
  def factors_for(number), do: factors_for(number, 2, [])
  def factors_for(1, _counter, result), do: result |> Enum.reverse
  def factors_for(number, counter, result) do
    if is_prime?(counter) && rem(number, counter) == 0 do
      factors_for(div(number, counter), 2, [counter | result])
    else
      if counter > 2, do: factors_for(number, counter + 2, result), else: factors_for(number, counter + 1, result)
    end
  end

  def is_prime?(num) when num < 2, do: false
  def is_prime?(num) when num == 2, do: true
  def is_prime?(num) when num == 3, do: true
  def is_prime?(num) when rem(num, 2) == 0, do: false
  def is_prime?(num) when rem(num, 3) == 0, do: false
  def is_prime?(num), do: is_prime?(num, num - 1)
  def is_prime?(_num, 4), do: true
  def is_prime?(num, counter) when rem(num, counter) == 0, do: false
  def is_prime?(num, counter), do: is_prime?(num, counter - 1)
end
