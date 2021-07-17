defmodule OnMars.Rovers.Commands.MoveTest do
  use ExUnit.Case

  import OnMars.Factory

  alias OnMars.{Coordinates, Error}
  alias OnMars.Rovers.Commands.Move

  @x_axis_upper_limit Application.compile_env(:on_mars, [:constants, :x_axis_upper_limit])
  @y_axis_upper_limit Application.compile_env(:on_mars, [:constants, :y_axis_upper_limit])
  @axis_bottom_limit 0

  @right_index 0
  @bottom_index 1
  @left_index 2
  @top_index 3

  @move :M

  describe "call/2" do
    test "when facing right, receive a command to move and " <>
           "x coordinate still below the x_axis_limit, move to the new x coordinate" do
      coordinates = build(:coordinates, %{x: @x_axis_upper_limit - 1})

      expected_response = {
        :ok,
        %Coordinates{x: @x_axis_upper_limit, y: 0, direction_index: @right_index}
      }

      response = Move.call(coordinates, @move)

      assert response == expected_response
    end

    test "when facing left, receive a command to move and " <>
           "x coordinate still above the axis_bottom_limit, move to the new x coordinate" do
      coordinates =
        build(
          :coordinates,
          %{x: @axis_bottom_limit + 1, direction_index: @left_index}
        )

      expected_response = {
        :ok,
        %Coordinates{x: @axis_bottom_limit, y: 0, direction_index: @left_index}
      }

      response = Move.call(coordinates, @move)

      assert response == expected_response
    end

    test "when facing top, receive a command to move and " <>
           "y coordinate still below the y_axis_limit, move to the new y coordinate" do
      coordinates =
        build(
          :coordinates,
          %{y: @y_axis_upper_limit - 1, direction_index: @top_index}
        )

      expected_response = {
        :ok,
        %Coordinates{x: 0, y: @y_axis_upper_limit, direction_index: @top_index}
      }

      response = Move.call(coordinates, @move)

      assert response == expected_response
    end

    test "when facing bottom, receive a command to move and " <>
           "y coordinate still above the axis_bottom_limit, move to the new y coordinate" do
      coordinates =
        build(
          :coordinates,
          %{y: @axis_bottom_limit + 1, direction_index: @bottom_index}
        )

      expected_response = {
        :ok,
        %Coordinates{x: 0, y: @axis_bottom_limit, direction_index: @bottom_index}
      }

      response = Move.call(coordinates, @move)

      assert response == expected_response
    end

    test "when facing right and receive a command to move that " <>
           "make the rover pass the x_axis_upper_limit, returns an error" do
      coordinates = build(:coordinates, %{x: @x_axis_upper_limit})

      expected_response = {
        :error,
        %Error{
          status: :bad_request,
          reason: "A sonda detectou que essa série de comandos não pode ser executada!"
        }
      }

      response = Move.call(coordinates, @move)

      assert response == expected_response
    end

    test "when facing left and receive a command to move that " <>
           "make the rover pass the axis_bottom_limit, returns an error" do
      coordinates =
        build(
          :coordinates,
          %{x: @axis_bottom_limit, direction_index: @left_index}
        )

      expected_response = {
        :error,
        %Error{
          status: :bad_request,
          reason: "A sonda detectou que essa série de comandos não pode ser executada!"
        }
      }

      response = Move.call(coordinates, @move)

      assert response == expected_response
    end

    test "when facing top and receive a command to move that " <>
           "make the rover pass y_axis_upper_limit, returns an error" do
      coordinates =
        build(
          :coordinates,
          %{y: @y_axis_upper_limit, direction_index: @top_index}
        )

      expected_response = {
        :error,
        %Error{
          status: :bad_request,
          reason: "A sonda detectou que essa série de comandos não pode ser executada!"
        }
      }

      response = Move.call(coordinates, @move)

      assert response == expected_response
    end

    test "when facing bottom and receive a command to move that " <>
           "make the rover pass the axis_bottom_limit, returns an error" do
      coordinates =
        build(
          :coordinates,
          %{y: @axis_bottom_limit, direction_index: @bottom_index}
        )

      expected_response = {
        :error,
        %Error{
          status: :bad_request,
          reason: "A sonda detectou que essa série de comandos não pode ser executada!"
        }
      }

      response = Move.call(coordinates, @move)

      assert response == expected_response
    end
  end
end
