defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors), do: to(limit, factors, [])
  def to(_limit, [], new_factors) do
    if length(new_factors) > 0 do
      new_factors
      |> Enum.uniq
      |> Enum.reduce(fn(factor, acc) -> factor + acc end)
    else
      0
    end
  end
  def to(limit, [head | tail], new_factors) do
    to(limit, tail, new_factors ++ get_multiples_up_to(limit, head))
  end

  def get_multiples_up_to(number, factor), do: get_multiples_up_to(number, factor, 2, [factor])
  def get_multiples_up_to(number, factor, _multiplier, _result) when factor >= number, do: []
  def get_multiples_up_to(number, _factor, _multiplier, [head | tail]) when head >= number, do: tail
  def get_multiples_up_to(number, factor, multiplier, result) do
    get_multiples_up_to(number, factor, multiplier + 1, [factor * multiplier | result])
  end
end
