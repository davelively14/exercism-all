defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @day_of_week %{saturday: 0, sunday: 1, monday: 2, tuesday: 3, wednesday: 4, thursday: 5, friday: 6}
  @offset_month_n %{1 => 0, 2 => 31, 3 => 59, 4 => 90, 5 => 120, 6 => 151, 7 => 181, 8 => 212, 9 => 243, 10 => 273, 11 => 304, 12 => 334}
  @offset_month_l %{1 => 0, 2 => 31, 3 => 60, 4 => 91, 5 => 121, 6 => 152, 7 => 182, 8 => 213, 9 => 244, 10 => 274, 11 => 305, 12 => 335}
  @days_in_month_n %{1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31}
  @days_in_month_l %{1 => 31, 2 => 29, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31}

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  # Note: I'm assuming all dates will be in the 2000 century
  def meetup(year, month, weekday, schedule) do
    {start_of_month, days_in_month} =
      case leap_year?(year) do
        true -> {rem(year_offset(year) + @offset_month_l[month], 7), @days_in_month_l[month]}
        false -> {rem(year_offset(year) + @offset_month_n[month], 7), @days_in_month_n[month]}
      end

    weekday_index = @day_of_week[weekday]

    # IO.inspect %{weekday: weekday_index, som: start_of_month}
    day =
      case schedule do
        :first -> of_the_month(weekday_index, start_of_month, 1)
        :second -> of_the_month(weekday_index, start_of_month, 2)
        :third -> of_the_month(weekday_index, start_of_month, 3)
        :fourth -> of_the_month(weekday_index, start_of_month, 4)
        :last -> get_last(weekday_index, start_of_month, days_in_month)
        :teenth -> get_teenth(weekday_index, start_of_month)
      end

    {year, month, day}
  end

  def leap_year?(year) when rem(year, 400) == 0, do: true
  def leap_year?(year) when rem(year, 100) == 0, do: false
  def leap_year?(year) when rem(year, 4) != 0, do: false
  def leap_year?(_year), do: true

  def year_offset(year), do: (year - 2000) * 365 + div(year - 2000, 4)

  def of_the_month(weekday, start_of_month, of_month) do
    cond do
      weekday == start_of_month -> (7 * of_month)
      weekday > start_of_month -> (7 * of_month - 7) + weekday - start_of_month
      true -> (weekday + 7) - start_of_month + (7 * of_month - 7)
    end
  end

  def get_last(weekday, start_of_month, days_in_month), do: get_last(of_the_month(weekday, start_of_month, 1), days_in_month)
  def get_last(current, days_in_month) do
    if current + 7 > days_in_month, do: current, else: get_last(current + 7, days_in_month)
  end

  def get_teenth(weekday, start_of_month), do: get_teenth(of_the_month(weekday, start_of_month, 1))
  def get_teenth(current) when current < 13, do: get_teenth(current + 7)
  def get_teenth(current), do: current
end
