defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2), do: {:error, "Lists must be the same length"}
  def hamming_distance(strand1, strand2), do: hamming_distance(strand1, strand2, 0)
  def hamming_distance([], [], diff), do: {:ok, diff}
  def hamming_distance([head_a | tail_a], [head_b | tail_b], diff) do
    if head_a == head_b do
      hamming_distance(tail_a, tail_b, diff)
    else
      hamming_distance(tail_a, tail_b, diff + 1)
    end
  end
end
