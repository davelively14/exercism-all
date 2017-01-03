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
  def generate(min, max), do: generate(min, max, [min, min + 1, min * min + (min + 1) * (min + 1)])
  def generate(min, max, [a, b, c_raw]) do
    IO.inspect %{a: a, b: b, c_raw: c_raw}
    cond do
      :math.sqrt(c_raw) > max -> [0, 0, 0]
      rem(:math.sqrt(c_raw) * 10 |> round, 10) == 0 -> [a, b, :math.sqrt(c_raw) |> round]
      true -> generate(min, max, [a + 1, b + 1, (a + 1) * (a + 1) + (b + 1) * (b + 1)])
    end
  end

  @doc """
  Generates a list of pythagorean triplets from a given min to a given max, whose values add up to a given sum.
  """
  @spec generate(non_neg_integer, non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max, sum) do
  end
end
