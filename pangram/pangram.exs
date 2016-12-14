defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """

  @spec pangram?(String.t) :: boolean
  def pangram?(sentence) do
    unique_letters =
      sentence |> String.downcase |> String.graphemes |> Enum.uniq |> Enum.filter(&(&1 =~ ~r/[a-z]/))
    length(unique_letters) == 26
  end
end
