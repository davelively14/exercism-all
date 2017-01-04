defmodule Allergies do
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags), do: list(rem(flags, 256), [])
  def list(0, result), do: result
  def list(flags, result) do
    cond do
      rem(flags, 128) == 0 -> list(flags - 128, ["cats" | result])
      rem(flags, 64) == 0  -> list(flags - 64, ["pollen" | result])
      rem(flags, 32) == 0  -> list(flags - 32, ["chocolate" | result])
      rem(flags, 16) == 0  -> list(flags - 16, ["tomatoes" | result])
      rem(flags, 8) == 0   -> list(flags - 8, ["strawberries" | result])
      rem(flags, 4) == 0   -> list(flags - 4, ["shellfish" | result])
      rem(flags, 2) == 0   -> list(flags - 2, ["peanuts" | result])
      true                 -> list(flags - 1, ["eggs" | result])
    end
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item) do
    allergies = list(flags)
    Enum.any?(allergies, &(&1 == item))
  end
end
