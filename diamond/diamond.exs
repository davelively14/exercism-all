defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(letter) do
    length = (letter - 65)
    build_shape(?A, length, 0, "")
  end
  def build_shape(letter, length, counter, result) when counter > length, do: result |> add_bottom
  def build_shape(letter, length, counter, result) when counter == 0 do
    spaces = String.pad_leading("", length - counter)
    build_shape(letter, length, counter + 1, result <> spaces <> <<letter>> <> spaces <> "\n")
  end
  def build_shape(letter, length, counter, result) do
    bookends = String.pad_leading("", length - counter)
    middle  = String.pad_leading("", (counter - 1) * 2 + 1)
    build_shape(letter, length, counter + 1, result <> bookends <> <<letter + counter>> <> middle <> <<letter + counter>> <> bookends <> "\n")
  end

  def add_bottom(string) do
    add_bottom(string |> String.split("\n") |> Enum.reverse, 0, string)
  end
  def add_bottom([], counter, result), do: result
  def add_bottom([_head | tail], counter, result) when counter < 2, do: add_bottom(tail, counter + 1, result)
  def add_bottom([head | tail], counter, result) do
    add_bottom(tail, counter + 1, result <> head <> "\n")
  end
end
