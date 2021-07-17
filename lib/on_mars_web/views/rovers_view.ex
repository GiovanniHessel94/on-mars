defmodule OnMarsWeb.RoversView do
  use OnMarsWeb, :view

  alias OnMars.Coordinates

  def render("execute.json", %{result: %Coordinates{x: x, y: y}}) do
    %{
      message: "Comandos executados com sucesso!",
      data: %{
        x: x,
        y: y
      }
    }
  end

  def render("show.json", %{result: %Coordinates{} = coordinates}) do
    %{
      message: "Coordenatas obtidas com sucesso!",
      data: Coordinates.to_map_response(coordinates)
    }
  end
end
