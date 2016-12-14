defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates), do: match(base, candidates, [])
  def match(_base, [], result), do: result

  # Couldn't use guard clauses because we can't invoke remote functions within
  # them. Used cond instead.
  def match(base, [head | tail], result) do
    cond do
      String.length(head) != String.length(base) ->
        match(base, tail, result)
      String.downcase(base) == String.downcase(head) ->
        match(base, tail, result)
      true ->
        word_a = base |> clean_string
        word_b = head |> clean_string

        if word_a == word_b do
          match(base, tail, result ++ [head])
        else
          match(base, tail, result)
        end

    end
  end

  defp clean_string(string) do
    string |> String.downcase |> String.graphemes |> Enum.sort |> to_string
  end
end
