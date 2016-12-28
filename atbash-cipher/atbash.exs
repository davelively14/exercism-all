defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode(plaintext), do: encode(plaintext |> String.downcase |> String.codepoints |> Enum.filter(&(&1 =~ ~r/[a-z0-9]/)), [])
  def encode([], result), do: result |> Enum.reverse |> add_spaces |> Enum.reverse |> to_string
  # def encode(plaintext, result) when rem(length(result), 6) == 0, do: encode(plaintext, [" " | result])
  def encode([head | tail], result) do
    <<codepoint::utf8>> = head
    case head =~ ~r/[a-z]/ do
      true -> encode(tail, [<<(25 - (codepoint - ?a)) + 97>> | result])
      _ -> encode(tail, [head | result])
    end

  end

  def add_spaces(list), do: add_spaces(list, [], 0)
  def add_spaces([], result, _counter), do: result
  def add_spaces(list, result, 5), do: add_spaces(list, [" " | result], 0)
  def add_spaces([head | tail], result, counter), do: add_spaces(tail, [head | result], counter + 1)
end
