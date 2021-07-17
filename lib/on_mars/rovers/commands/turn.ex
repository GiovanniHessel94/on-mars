defmodule OnMars.Rovers.Commands.Turn do
  alias OnMars.Coordinates

  @right_index 0
  @top_index 3

  @turn_left :GE
  @turn_right :GD

  def call(%Coordinates{} = coordinates, command) do
    coordinates
    |> do_turn(command)
    |> handle_turn()
  end

  defp do_turn(%Coordinates{direction_index: @right_index} = coordinates, @turn_left) do
    Map.put(coordinates, :direction_index, @top_index)
  end

  defp do_turn(%Coordinates{direction_index: direction_index} = coordinates, @turn_left) do
    Map.put(coordinates, :direction_index, direction_index - 1)
  end

  defp do_turn(%Coordinates{direction_index: @top_index} = coordinates, @turn_right) do
    Map.put(coordinates, :direction_index, @right_index)
  end

  defp do_turn(%Coordinates{direction_index: direction_index} = coordinates, @turn_right) do
    Map.put(coordinates, :direction_index, direction_index + 1)
  end

  defp handle_turn(%Coordinates{} = new_coordinates), do: {:ok, new_coordinates}
end
