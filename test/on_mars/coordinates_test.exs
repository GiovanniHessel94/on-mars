defmodule OnMars.CoordinatesTest do
  use ExUnit.Case

  import OnMars.Factory

  alias OnMars.{Coordinates, Error}

  describe "build/3" do
    test "when all params are valid, returns a coordinates struct" do
      x = 0
      y = 0
      direction_index = 0

      response = Coordinates.build(x, y, direction_index)

      assert {:ok, %Coordinates{}} = response
    end

    test "when there is an invalid param, returns an error" do
      invalid_x = -1
      invalid_y = -1
      invalid_direction_index = 4

      expected_response = {
        :error,
        %Error{status: :bad_request, reason: "Parâmetros de cooordenada inválidos"}
      }

      response = Coordinates.build(invalid_x, invalid_y, invalid_direction_index)

      assert response == expected_response
    end
  end

  describe "to_map_response/1" do
    test "when an valid coordinates is given, returns its map response representation" do
      coordinates = build(:coordinates, %{direction_index: 3})

      expected_response = %{
        x: 0,
        y: 0,
        direction: "C"
      }

      response = Coordinates.to_map_response(coordinates)

      assert response == expected_response
    end
  end
end
