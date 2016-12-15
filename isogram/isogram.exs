defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence), do: isogram?(sentence |> clean_list, [])
  def isogram?([], _tracker), do: true
  def isogram?([head | tail], tracker) do
    if in_tracker(head, tracker) do
      false
    else
      isogram?(tail, [head | tracker])
    end
  end

  defp clean_list(string) do
    string |> String.downcase |> String.graphemes |> Enum.filter(&(&1 =~ ~r/[\p{L}]/))
  end

  defp in_tracker(item, []), do: false
  defp in_tracker(item, [head | tail]) when head == item, do: true
  defp in_tracker(item, [head | tail]), do: in_tracker(item, tail)
end
