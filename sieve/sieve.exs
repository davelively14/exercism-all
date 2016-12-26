defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit), do: primes_to(Enum.to_list(2..limit), [])
  def primes_to([], result), do: result |> Enum.reverse
  def primes_to([head | tail], result), do: primes_to(remove_multiples(head, tail), [head | result])

  def remove_multiples(base, list), do: remove_multiples(base, list, [])
  def remove_multiples(_base, [], result), do: result |> Enum.reverse
  def remove_multiples(base, [head | tail], result) when rem(head, base) == 0, do: remove_multiples(base, tail, result)
  def remove_multiples(base, [head | tail], result), do: remove_multiples(base, tail, [head | result])
end
