defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @open_brackets ["[", "{", "("]
  @close_brackets ["]", "}", ")"]
  @trans_brackets %{"]" => "[", "}" => "{", ")" => "("}

  @spec check_brackets(String.t) :: boolean
  def check_brackets(str), do: check_brackets(str |> String.graphemes, ["good"])
  def check_brackets([], tracker), do: if tracker == ["good"], do: true, else: false
  def check_brackets([head | tail], tracker = [open | blocked]) do
    cond do
      Enum.any?(@open_brackets, &(&1 == head)) ->
        check_brackets(tail, [head | tracker])
      Enum.any?(@close_brackets, &(&1 == head)) ->
        key = Map.get(@trans_brackets, head)
        if open == key, do: check_brackets(tail, blocked), else: false
      true ->
        check_brackets(tail, tracker)
    end
  end
end
