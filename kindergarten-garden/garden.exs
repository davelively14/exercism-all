defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """
  @students [:alice, :bob, :charlie, :david, :eve, :fred, :ginny, :harriet, :ileana, :joseph, :kincaid, :larry]
  @cups %{"V" => :violets, "C" => :clover, "G" => :grass, "R" => :radishes}
  @spots_per_row 24

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @students) do
    students = student_names |> Enum.sort
    crops = info_string |> String.split("\n") |> group_crops

    plant_garden(crops, students)
  end

  defp set_crops(pattern), do: set_crops(pattern, [])
  defp set_crops([], result), do: result
  defp set_crops([head | tail], result) do
    set_crops(tail, result ++ [String.duplicate(head, div(@spots_per_row, String.length(head)))])
  end

  defp group_crops(rows), do: group_crops(List.first(rows) |> String.graphemes, List.last(rows) |> String.graphemes, [])
  defp group_crops([], [], crops), do: crops |> Enum.reverse
  defp group_crops([head_1a | tail_1], [head_2a | tail_2], crops) do
    [head_1b | next_tail_1] = tail_1
    [head_2b | next_tail_2] = tail_2
    result = {Map.get(@cups, head_1a), Map.get(@cups, head_1b), Map.get(@cups, head_2a), Map.get(@cups, head_2b)}
    group_crops(next_tail_1, next_tail_2, [result | crops])
  end

  defp plant_garden(crops, students), do: plant_garden(crops, students, %{})
  defp plant_garden([], [], garden), do: garden
  defp plant_garden([], [first_student | students_tail], results) do
    plant_garden([], students_tail, Map.put(results, first_student, {}))
  end
  defp plant_garden([first_crop | crops_tail], [first_student | students_tail], results) do
    plant_garden(crops_tail, students_tail, Map.put(results, first_student, first_crop))
  end
end
