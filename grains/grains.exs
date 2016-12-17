defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) do
    :math.pow(2, number - 1) |> round
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total, do: total(1, 0)
  def total(64, sum), do: sum + square(64)
  def total(counter, sum), do: total(counter + 1, sum + square(counter))
end
