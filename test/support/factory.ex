defmodule OnMars.Factory do
  use ExMachina

  alias OnMars.{Commands, Coordinates}

  def commands_params_factory do
    %{
      "commands" => ["M", "GE", "M", "GD"]
    }
  end

  def commands_factory do
    :commands_params
    |> build()
    |> Commands.changeset()
  end

  def coordinates_factory do
    %Coordinates{
      x: 0,
      y: 0,
      direction_index: 0
    }
  end
end
