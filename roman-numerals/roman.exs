defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(number), do: numerals(number, "")
  def numerals(0, result), do: result
  def numerals(number, result) when number >= 1000, do: numerals(number - 1000, result <> "M")
  def numerals(number, result) when number >= 900, do: numerals(number - 900, result <> "CM")
  def numerals(number, result) when number >= 500, do: numerals(number - 500, result <> "D")
  def numerals(number, result) when number >= 400, do: numerals(number - 400, result <> "CD")
  def numerals(number, result) when number >= 100, do: numerals(number - 100, result <> "C")
  def numerals(number, result) when number >= 90, do: numerals(number - 90, result <> "XC")
  def numerals(number, result) when number >= 50, do: numerals(number - 50, result <> "L")
  def numerals(number, result) when number >= 40, do: numerals(number - 40, result <> "XL")
  def numerals(number, result) when number >= 10, do: numerals(number - 10, result <> "X")
  def numerals(number, result) when number >= 9, do: numerals(number - 9, result <> "IX")
  def numerals(number, result) when number >= 5, do: numerals(number - 5, result <> "V")
  def numerals(number, result) when number >= 4, do: numerals(number - 4, result <> "IV")
  def numerals(number, result), do: numerals(number - 1, result <> "I")
end
