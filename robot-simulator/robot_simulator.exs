defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @valid_dir [:north, :east, :south, :west]

  @spec create(direction :: atom, position :: { integer, integer }) :: any
  def create(direction \\ :north, position \\ {0, 0}) do
    cond do
      Enum.member?(@valid_dir, direction) == false ->
        { :error, "invalid direction" }
      is_valid_position?(position) == false ->
        { :error, "invalid position" }
      true ->
        %{direction: direction, position: position}
    end
  end

  defp is_valid_position?({x, y}) do
    cond do
      is_integer(x) && is_integer(y) -> true
      true -> false
    end
  end
  defp is_valid_position?(_), do: false

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t ) :: any
  def simulate(robot, instructions) when is_bitstring(instructions), do: simulate(robot, String.graphemes(instructions))
  def simulate(robot, []), do: robot
  def simulate(robot, [head | tail]) do
    case head do
      "A" -> simulate(advance(robot), tail)
      "L" -> simulate(turn("L", robot), tail)
      "R" -> simulate(turn("R", robot), tail)
      _ -> { :error, "invalid instruction" }
    end
  end

  defp advance(robot) do
    {x, y} = robot.position
    case robot.direction do
      :north -> Map.update!(robot, :position, fn _x -> {x, y + 1} end)
      :south -> Map.update!(robot, :position, fn _x -> {x, y - 1} end)
      :east -> Map.update!(robot, :position, fn _x -> {x + 1, y} end)
      :west -> Map.update!(robot, :position, fn _x -> {x - 1, y} end)
    end
  end

  defp turn("L", robot) do
    case robot.direction do
      :north -> Map.update!(robot, :direction, fn _x -> :west end)
      :south -> Map.update!(robot, :direction, fn _x -> :east end)
      :east -> Map.update!(robot, :direction, fn _x -> :north end)
      :west -> Map.update!(robot, :direction, fn _x -> :south end)
    end
  end

  defp turn("R", robot) do
    case robot.direction do
      :north -> Map.update!(robot, :direction, fn _x -> :east end)
      :south -> Map.update!(robot, :direction, fn _x -> :west end)
      :east -> Map.update!(robot, :direction, fn _x -> :south end)
      :west -> Map.update!(robot, :direction, fn _x -> :north end)
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot), do: robot.direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: { integer, integer }
  def position(robot), do: robot.position
end
