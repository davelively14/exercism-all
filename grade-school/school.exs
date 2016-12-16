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
    if Map.has_key?(db, :students) do
      %{students: [%{name: name, grade: grade} | Map.get(db, :students)]}
    else
      %{students: [%{name: name, grade: grade}]}
    end
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t]
  def grade(db, grade) do
    get_students(db.students, grade)
  end

  defp get_students(all_students, grade), do: get_students(all_students, grade, [])
  defp get_students([], _grade, results), do: results |> Enum.sort
  defp get_students([head | tail], grade, results) do
    if head.grade == grade do
      get_students(tail, grade, [head.name | results])
    else
      get_students(tail, grade, results)
    end
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t]}]
  def sort(db) do
    get_all_grades(db.students)
    |> get_names(db)
    |> Enum.sort
  end

  defp get_all_grades(students) do
    Enum.map(students, &(&1.grade)) |> Enum.uniq
  end

  def get_names(grades, db), do: get_names(grades, db, [])
  def get_names([], _db, results), do: results
  def get_names([head | tail], db, results) do
    get_names(tail, db, [{head, grade(db, head)} | results])
  end
end
