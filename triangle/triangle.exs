defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, _b, _c) when a <= 0, do: {:error, "all side lengths must be positive"}
  def kind(_a, b, _c) when b <= 0, do: {:error, "all side lengths must be positive"}
  def kind(_a, _b, c) when c <= 0, do: {:error, "all side lengths must be positive"}
  def kind(a, b, c) when a >= (b + c), do: {:error, "side lengths violate triangle inequality"}
  def kind(a, b, c) when b >= (a + c), do: {:error, "side lengths violate triangle inequality"}
  def kind(a, b, c) when c >= (a + b), do: {:error, "side lengths violate triangle inequality"}
  def kind(a, b, c) do
    cond do
      a == b &&  b == c -> {:ok, :equilateral}
      a == b || b == c || a == c -> {:ok, :isosceles}
      true -> {:ok, :scalene}
    end
  end
end
