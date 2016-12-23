defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    list = hex |> String.graphemes |> Enum.reverse
    if valid_hex?(list), do: to_decimal(list, 0, 0), else: 0
  end
  def to_decimal([], _n, result), do: result
  def to_decimal([head | tail], n, result) do
    to_decimal(tail, n + 1, result + ((:math.pow(16, n) |> round)) * get_hex_value(head))
  end

  def valid_hex?([]), do: true
  def valid_hex?([head | tail]), do: if String.downcase(head) =~ ~r/[0-9a-f]/, do: valid_hex?(tail), else: false

  def get_hex_value(str) do
    str = String.downcase(str)
    cond do
      str =~ ~r/[0-9]/ -> str |> String.to_integer
      str == "a" -> 10
      str == "b" -> 11
      str == "c" -> 12
      str == "d" -> 13
      str == "e" -> 14
      str == "f" -> 15
    end
  end
end
