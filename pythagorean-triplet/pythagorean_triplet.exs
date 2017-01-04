defmodule Triplet do

  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum(triplet), do: sum(triplet, 0)
  def sum([], result), do: result
  def sum([head | tail], result), do: sum(tail, result + head)

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product(triplet), do: product(triplet, 1)
  def product([], result), do: result
  def product([head | tail], result), do: product(tail, result * head)

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?([a, b, c]), do: (a * a) + (b * b) == c * c

  @doc """
  Generates a list of pythagorean triplets from a given min (or 1 if no min) to a given max.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max), do: inspect_this(min, max, [])
  def inspect_this(min, max, result) when min == max, do: result |> Enum.filter(&(&1 != []))
  def inspect_this(min, max, result) do
    # IO.inspect %{min: min, max: max, result: result}
    inspect_this(min + 1, max, result ++ [check_all(min, min + 1, max)])
  end

  def check_all(a, b, max) do
    # IO.inspect %{a: a, b: b, c: :math.sqrt(a*a + b*b)}
    cond do
      :math.sqrt(a*a + b*b) > max -> []
      rem(:math.sqrt(a*a + b*b) * 10 |> round, 10) == 0 -> [a, b, :math.sqrt(a*a + b*b) |> round]
      true -> check_all(a, b + 1, max)
    end
  end

  @doc """
  Generates a list of pythagorean triplets from a given min to a given max, whose values add up to a given sum.
  """
  @spec generate(non_neg_integer, non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max, sum) do
    triplets = generate(min, max)
    check_trips_vs_sum(triplets, sum)
  end

  def check_trips_vs_sum(triplets, sum), do: check_trips_vs_sum(triplets, sum, [])
  def check_trips_vs_sum([], _sum, result), do: result
  def check_trips_vs_sum([head | tail], sum, result) do
    IO.inspect %{head: head, sum: sum, result: result}
    cond do
      sum(head) == sum -> check_trips_vs_sum(tail, sum, result ++ head)
      true -> check_trips_vs_sum(tail, sum, result)
    end
  end
end
