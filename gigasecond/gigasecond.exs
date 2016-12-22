defmodule Gigasecond do
  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @minute 60
  @hour 60 * 60
  @day 60 * 60 * 24
  @leap_yr 60 * 60 * 24 * 366
  @yr 60 * 60 * 24 * 365
  @offset_month_n %{1 => 0, 2 => 31, 3 => 59, 4 => 90, 5 => 120, 6 => 151, 7 => 181, 8 => 212, 9 => 243, 10 => 273, 11 => 304, 12 => 334}
  @offset_month_l %{1 => 0, 2 => 31, 3 => 60, 4 => 91, 5 => 121, 6 => 152, 7 => 182, 8 => 213, 9 => 244, 10 => 274, 11 => 305, 12 => 335}

  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime
  def from({{year, month, day}, {hours, minutes, seconds}}) do
    days = if leap_year?(year), do: @offset_month_l[month] + day, else: @offset_month_n[month] + day
    from({{year, days}, {hours, minutes, seconds}}, 1_000_000_000)
  end
  def from(date, 0) do
    date |> convert_to_date
  end
  def from({{year, days}, {hours, minutes, seconds}}, remaining) do
    cond do
      leap_year?(year) && remaining >= @leap_yr ->
        from({{year + 1, days}, {hours, minutes, seconds}}, remaining - @leap_yr)
      remaining >= @yr ->
        from({{year + 1, days}, {hours, minutes, seconds}}, remaining - @yr)
      remaining >= @day ->
        change = div(remaining, @day)
        from({{year, days + change}, {hours, minutes, seconds}}, remaining - (change * @day))
      remaining >= @hour ->
        change = div(remaining, @hour)
        from({{year, days}, {hours + change, minutes, seconds}}, remaining - (change * @hour))
      remaining >= @minute ->
        change = div(remaining, @minute)
        from({{year, days}, {hours, minutes + change, seconds}}, remaining - (change * @minute))
      true ->
        from({{year, days}, {hours, minutes, seconds + remaining}}, 0)
    end
  end

  def leap_year?(year) when rem(year, 400) == 0, do: true
  def leap_year?(year) when rem(year, 100) == 0, do: false
  def leap_year?(year) when rem(year, 4) != 0, do: false
  def leap_year?(_year), do: true

  # Turn days back into month, days
  def convert_to_date(date = {{year, days}, {hours, minutes, seconds}}) do
    cond do
      seconds > 60 ->
        convert_to_date({{year, days}, {hours, minutes + 1, seconds - 60}})
      minutes > 60 ->
        convert_to_date({{year, days}, {hours + 1, minutes - 60, seconds}})
      hours > 24 ->
        convert_to_date({{year, days + 1}, {hours - 24, minutes, seconds}})
      days > 366 && leap_year?(year) ->
        convert_to_date({{year + 1, days - 366}, {hours, minutes, seconds}})
      days > 365 ->
        convert_to_date({{year + 1, days - 365}, {hours, minutes, seconds}})
      true ->
        date |> make_date
    end
  end

  def make_date({{year, days}, {hours, minutes, seconds}}) do
    if leap_year?(year) do
      month =
        cond do
          days > @offset_month_l[12] -> 12
          days > @offset_month_l[11] -> 11
          days > @offset_month_l[10] -> 10
          days > @offset_month_l[9] -> 9
          days > @offset_month_l[8] -> 8
          days > @offset_month_l[7] -> 7
          days > @offset_month_l[6] -> 6
          days > @offset_month_l[5] -> 5
          days > @offset_month_l[4] -> 4
          days > @offset_month_l[3] -> 3
          days > @offset_month_l[2] -> 2
          true -> 1
        end
      {{year, month, days - @offset_month_l[month]}, {hours, minutes, seconds}}
    else
      month =
        cond do
          days > @offset_month_n[12] -> 12
          days > @offset_month_n[11] -> 11
          days > @offset_month_n[10] -> 10
          days > @offset_month_n[9] -> 9
          days > @offset_month_n[8] -> 8
          days > @offset_month_n[7] -> 7
          days > @offset_month_n[6] -> 6
          days > @offset_month_n[5] -> 5
          days > @offset_month_n[4] -> 4
          days > @offset_month_n[3] -> 3
          days > @offset_month_n[2] -> 2
          true -> 1
        end
      {{year, month, days - @offset_month_n[month]}, {hours, minutes, seconds}}
    end
  end
end
