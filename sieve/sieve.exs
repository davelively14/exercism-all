defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit), do: limit |> gen_list |> primes_to(limit, [])
  def primes_to([], _limit, result), do: result |> Enum.reverse
  def primes_to([head | tail], limit, result), do: primes_to(remove_multiples(head, tail), limit, [head | result])

  def gen_list(limit), do: gen_list(limit, limit, [])
  def gen_list(_limit, counter, result) when counter < 2, do: result
  def gen_list(limit, counter, result), do: gen_list(limit, counter - 1, [counter | result])

  def remove_multiples(base, list), do: remove_multiples(base, list, [])
  def remove_multiples(_base, [], result), do: result |> Enum.reverse
  def remove_multiples(base, [head | tail], result) when rem(head, base) == 0, do: remove_multiples(base, tail, result)
  def remove_multiples(base, [head | tail], result), do: remove_multiples(base, tail, [head | result])
end
