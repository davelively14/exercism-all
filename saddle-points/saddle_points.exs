defmodule Matrix do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n")
    |> Enum.map(&String.split(&1, " ") |> Enum.map(fn (x) -> String.to_integer(x) end))
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str), do: str |> rows |> List.zip |> Enum.map(&Tuple.to_list(&1))

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """

  # {row, column} <- starts at 0
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    all_rows = str |> rows
    all_cols = str |> columns
    check_by_rows(all_rows, all_cols)
  end

  def check_by_rows(all_rows, all_cols), do: check_by_rows(all_rows, all_cols, [], 0)
  def check_by_rows([], _, results, _), do: results |> Enum.reverse
  def check_by_rows([row | rows_tail], all_cols, results, row_num) do
    check_by_rows(rows_tail, all_cols, check_row(row, Enum.max(row), row_num, all_cols, results, 0), row_num + 1)
  end

  def check_row([], _, _, _, results, _), do: results
  def check_row([value | row_tail], max_in_row, row_num, cols, results, col_num) do
    if value >= max_in_row && value <= Enum.min(Enum.at(cols, col_num)) do
      check_row(row_tail, max_in_row, row_num, cols, [{row_num, col_num} | results], col_num + 1)
    else
      check_row(row_tail, max_in_row, row_num, cols, results, col_num + 1)
    end
  end
end
