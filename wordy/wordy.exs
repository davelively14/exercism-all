defmodule Wordy do

  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer(question), do: answer(String.split(question, " "), nil, nil)
  def answer([], _prev, result), do: if result, do: result, else: raise ArgumentError
  def answer([head | tail], prev, result) do
    cond do
      head =~ ~r/plus/ ->
        # IO.inspect %{result: result, head: head, prev: prev, next: List.first(tail)}
        ans = make_int(prev) + make_int(tail |> List.first)
        answer(tail |> pop, ans, ans)
      head =~ ~r/minus/ ->
        ans = make_int(prev) - make_int(tail |> List.first)
        answer(tail |> pop, ans, ans)
      head =~ ~r/multiplied/ ->
        ans = make_int(prev) * make_int(tail |> pop |> List.first)
        answer(tail |> pop |> pop, ans, ans)
      head =~ ~r/divided/ ->
        ans = div(make_int(prev), make_int(tail |> pop |> List.first))
        answer(tail |> pop |> pop, ans, ans)
      true ->
        answer(tail, head, result)
    end
  end

  def make_int(str) when is_bitstring(str), do: Regex.scan(~r/[0-9-]/, str) |> List.flatten |> to_string |> String.to_integer
  def make_int(int), do: int

  def pop([head | tail]), do: tail
end
