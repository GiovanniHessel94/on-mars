defmodule OnMars.Rovers.Agent do
  use Agent

  alias OnMars.Coordinates
  alias OnMars.Rovers.Commands.{Move, Turn}

  @turn_commands Application.compile_env(:on_mars, [:constants, :turn_commands])
  @move_commands Application.compile_env(:on_mars, [:constants, :move_commands])

  def start_link(name \\ __MODULE__, _opts) do
    Agent.start_link(fn -> initial_coordinates() end, name: name)
  end

  def reset_coordinates(name \\ __MODULE__) do
    Agent.update(name, fn _ -> initial_coordinates() end)
  end

  def get_coordinates(name \\ __MODULE__), do: {:ok, Agent.get(name, & &1)}

  def execute(name \\ __MODULE__, commands) do
    Agent.get_and_update(name, &do_execute(&1, commands))
  end

  defp initial_coordinates do
    {:ok, coordinates} = Coordinates.build(0, 0, 0)

    coordinates
  end

  defp do_execute(%Coordinates{} = coordinates, commands) do
    case call_command(coordinates, commands) do
      {:ok, %Coordinates{} = new_coordinates} = result -> {result, new_coordinates}
      {:error, _reason} = error -> {error, coordinates}
    end
  end

  defp call_command(%Coordinates{} = coordinates, [command | tail])
       when command in @turn_commands do
    with {:ok, %Coordinates{} = new_coordinates} <- Turn.call(coordinates, command) do
      call_command(new_coordinates, tail)
    end
  end

  defp call_command(%Coordinates{} = coordinates, [command | tail])
       when command in @move_commands do
    with {:ok, %Coordinates{} = new_coordinates} <- Move.call(coordinates, command) do
      call_command(new_coordinates, tail)
    end
  end

  defp call_command(%Coordinates{} = coordinates, []) do
    {:ok, coordinates}
  end
end
