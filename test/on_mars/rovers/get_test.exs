defmodule OnMars.Rovers.GetTest do
  use ExUnit.Case

  alias OnMars.Coordinates

  alias OnMars.Rovers.Get

  describe "call/0" do
    test "when called, should get the coordinates" do
      response = Get.coordinates()

      assert {:ok, %Coordinates{}} = response
    end
  end
end
