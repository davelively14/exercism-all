defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number), do: checksum(number |> String.graphemes |> Enum.filter(&(&1 =~ ~r/[0-9]/)) |> Enum.reverse, 0, 1)
  def checksum([], sum, _counter), do: sum
  def checksum([head | tail], sum, counter) when rem(counter, 2) == 0 do
    new_number = String.to_integer(head) * 2
    if new_number > 9 do
      checksum(tail, sum + new_number - 9, counter + 1)
    else
      checksum(tail, sum + new_number, counter + 1)
    end
  end
  def checksum([head | tail], sum, counter) do
    checksum(tail, sum + String.to_integer(head), counter + 1)
  end

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number), do: number |> checksum |> rem(10) == 0

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number), do: create(number, 0)
  def create(_number, counter) when counter > 9, do: :error
  def create(number, counter) do
    new_number = number <> Integer.to_string(counter)
    if valid?(new_number), do: new_number, else: create(number, counter + 1)
  end
end
