defmodule OnMarsWeb.RoversViewTest do
  use OnMarsWeb.ConnCase, async: true

  import Phoenix.View

  alias OnMars.Coordinates

  alias OnMarsWeb.RoversView

  test "renders execute.json" do
    {:ok, coordinates} = Coordinates.build(1, 2, 3)

    response = render(RoversView, "execute.json", result: coordinates)

    assert %{
             message: "Comandos executados com sucesso!",
             data: %{
               x: 1,
               y: 2
             }
           } = response
  end

  test "renders show.json" do
    {:ok, coordinates} = Coordinates.build(1, 2, 3)

    response = render(RoversView, "show.json", result: coordinates)

    assert %{
             message: "Coordenatas obtidas com sucesso!",
             data: %{
               x: 1,
               y: 2,
               direction: "C"
             }
           } = response
  end
end
