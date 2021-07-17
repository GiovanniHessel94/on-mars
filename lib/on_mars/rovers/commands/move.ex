defmodule OnMars.Rovers.Commands.Move do
  alias OnMars.{Coordinates, Error}

  @x_axis_upper_limit Application.compile_env(:on_mars, [:constants, :x_axis_upper_limit])
  @y_axis_upper_limit Application.compile_env(:on_mars, [:constants, :y_axis_upper_limit])
  @axis_bottom_limit 0

  @right_index 0
  @bottom_index 1
  @left_index 2
  @top_index 3

  @move :M

  def call(%Coordinates{} = coordinates, command) do
    coordinates
    |> do_move(command)
    |> handle_move()
  end

  defp do_move(%Coordinates{x: x, direction_index: @right_index} = coordinates, @move)
       when x < @x_axis_upper_limit do
    Map.put(coordinates, :x, x + 1)
  end

  defp do_move(%Coordinates{x: x, direction_index: @left_index} = coordinates, @move)
       when x > @axis_bottom_limit do
    Map.put(coordinates, :x, x - 1)
  end

  defp do_move(%Coordinates{y: y, direction_index: @top_index} = coordinates, @move)
       when y < @y_axis_upper_limit do
    Map.put(coordinates, :y, y + 1)
  end

  defp do_move(%Coordinates{y: y, direction_index: @bottom_index} = coordinates, @move)
       when y > @axis_bottom_limit do
    Map.put(coordinates, :y, y - 1)
  end

  defp do_move(_coordinates, _command), do: :error

  defp handle_move(%Coordinates{} = new_coordinates), do: {:ok, new_coordinates}

  defp handle_move(:error) do
    {
      :error,
      Error.build(
        :bad_request,
        "A sonda detectou que essa série de comandos não pode ser executada!"
      )
    }
  end
end
