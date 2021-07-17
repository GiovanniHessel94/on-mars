defmodule OnMars.Rovers.Commands.TurnTest do
  use ExUnit.Case

  import OnMars.Factory

  alias OnMars.Coordinates
  alias OnMars.Rovers.Commands.Turn

  @right_index 0
  @bottom_index 1
  @left_index 2
  @top_index 3

  @turn_left :GE
  @turn_right :GD

  describe "call/2" do
    test "when facing right and receive a command to turn left, should face top" do
      coordinates = build(:coordinates)

      expected_response = {:ok, %Coordinates{direction_index: @top_index, x: 0, y: 0}}

      response = Turn.call(coordinates, @turn_left)

      assert response == expected_response
    end

    test "when facing top and receive a command to turn left, should face left" do
      coordinates = build(:coordinates, %{direction_index: @top_index})

      expected_response = {:ok, %Coordinates{direction_index: @left_index, x: 0, y: 0}}

      response = Turn.call(coordinates, @turn_left)

      assert response == expected_response
    end

    test "when facing left and receive a command to turn left, should face bottom" do
      coordinates = build(:coordinates, %{direction_index: @left_index})

      expected_response = {:ok, %Coordinates{direction_index: @bottom_index, x: 0, y: 0}}

      response = Turn.call(coordinates, @turn_left)

      assert response == expected_response
    end

    test "when facing bottom and receive a command to turn left, should face right" do
      coordinates = build(:coordinates, %{direction_index: @bottom_index})

      expected_response = {:ok, %Coordinates{direction_index: @right_index, x: 0, y: 0}}

      response = Turn.call(coordinates, @turn_left)

      assert response == expected_response
    end

    test "when facing right and receive a command to turn right, should face bottom" do
      coordinates = build(:coordinates)

      expected_response = {:ok, %Coordinates{direction_index: @bottom_index, x: 0, y: 0}}

      response = Turn.call(coordinates, @turn_right)

      assert response == expected_response
    end

    test "when facing bottom and receive a command to turn right, should face left" do
      coordinates = build(:coordinates, %{direction_index: @bottom_index})

      expected_response = {:ok, %Coordinates{direction_index: @left_index, x: 0, y: 0}}

      response = Turn.call(coordinates, @turn_right)

      assert response == expected_response
    end

    test "when facing left and receive a command to turn right, should face top" do
      coordinates = build(:coordinates, %{direction_index: @left_index})

      expected_response = {:ok, %Coordinates{direction_index: @top_index, x: 0, y: 0}}

      response = Turn.call(coordinates, @turn_right)

      assert response == expected_response
    end

    test "when facing top and receive a command to turn right, should face right" do
      coordinates = build(:coordinates, %{direction_index: @top_index})

      expected_response = {:ok, %Coordinates{direction_index: @right_index, x: 0, y: 0}}

      response = Turn.call(coordinates, @turn_right)

      assert response == expected_response
    end
  end
end
