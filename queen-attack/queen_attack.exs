defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  # @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white \\ {0, 3}, black \\ {7, 3}) do
    if white == black do
      raise(ArgumentError)
    else
      %{white: white, black: black}
    end
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(queens) do
    board = String.strip """
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    _ _ _ _ _ _ _ _
    """

    board
    |> place_queen(queens.white, "W")
    |> place_queen(queens.black, "B")
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens) do
    cond do
      queens.white |> elem(0) == queens.black |> elem(0) -> true
      queens.white |> elem(1) == queens.black |> elem(1) -> true
      abs(elem(queens.white, 0) - elem(queens.black, 0)) == abs(elem(queens.white, 1) - elem(queens.black, 1)) -> true
      true -> false
    end
  end

  def place_queen(board, {x, y}, color) do
    position = (x * 16) + (y * 2)
    String.slice(board, 0, position) <> color <> String.slice(board, position + 1, String.length(board))
  end
end
