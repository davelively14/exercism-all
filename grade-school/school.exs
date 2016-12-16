defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t, integer) :: map
  def add(db, name, grade) do
    if Map.has_key?(db, grade) do
      Map.get_and_update(db, grade, &({&1, &1 ++ [name]})) |> elem(1)
    else
      Map.put(db, grade, [name])
    end
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t]
  def grade(db, grade) do
    if Map.has_key?(db, grade), do: db[grade], else: []
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t]}]
  def sort(db) do
    Map.keys(db) |> Enum.sort |> Enum.map(&({&1, Map.get(db, &1) |> Enum.sort}))
  end
end
