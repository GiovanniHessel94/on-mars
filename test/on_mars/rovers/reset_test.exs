defmodule OnMars.Rovers.ResetTest do
  use ExUnit.Case

  alias OnMars.Rovers.Reset

  describe "call/0" do
    test "when called, should reset the coordinates" do
      expected_response = {:ok, "Sonda posicionada nas coordenadas iniciais!"}

      response = Reset.coordinates()

      assert response == expected_response
    end
  end
end
