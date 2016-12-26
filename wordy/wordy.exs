defmodule Wordy do

  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer(question), do: answer(String.split(question, " "), nil, 0)
  def answer([], _prev, answer), do: answer
  def answer([head | tail], prev, answer) do
    cond do
      head =~ ~r/plus/ ->
        make_int(prev) + make_int(tail |> List.first)
      true ->
        answer(tail, head, answer)
    end
  end

  def make_int(str), do: Regex.scan(~r/[0-9-]/, str) |> List.flatten |> to_string |> String.to_integer
end
