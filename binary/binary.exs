defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    list = string |> String.graphemes |> Enum.reverse
    if check_numeric(list) do
      to_decimal(list, 0, 0)
    else
      0
    end
  end
  def to_decimal([], _n, result), do: result
  def to_decimal([head | tail], n, result) do
    to_decimal(tail, n + 1, result + ((:math.pow(2, n) |> round) * String.to_integer(head)))
  end

  def check_numeric([]), do: true
  def check_numeric([head | tail]), do: if head =~ ~r/[0-1]/, do: check_numeric(tail), else: false
end
