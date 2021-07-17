defmodule OnMars.Rovers.AgentTest do
  use ExUnit.Case, async: false

  import OnMars.Factory

  alias Ecto.Changeset

  alias OnMars.{Coordinates, Error}
  alias OnMars.Rovers.Agent, as: RoverAgent

  describe "get_coordinates/0" do
    setup do
      agent_name = :agent_get_coordinates

      {:ok, _pid} = RoverAgent.start_link(agent_name, %{})

      {:ok, agent_name: agent_name}
    end

    test "when called, should get the coordinates", %{agent_name: agent_name} do
      expected_response = {:ok, build(:coordinates)}

      response = RoverAgent.get_coordinates(agent_name)

      assert response == expected_response
    end
  end

  describe "execute/1" do
    setup do
      agent_name = :agent_execute

      {:ok, _pid} = RoverAgent.start_link(agent_name, %{})

      {:ok, agent_name: agent_name}
    end

    test "when called, should execute the commands", %{agent_name: agent_name} do
      %Changeset{changes: %{commands: commands}, valid?: true} = build(:commands)

      expected_response = {
        :ok,
        %Coordinates{x: 1, y: 1, direction_index: 0}
      }

      response = RoverAgent.execute(agent_name, commands)

      assert response == expected_response
    end

    test "when the commands cannot be executed, return an error", %{agent_name: agent_name} do
      commands = [:GD, :M, :M]

      expected_response = {
        :error,
        %Error{
          reason: "A sonda detectou que essa série de comandos não pode ser executada!",
          status: :bad_request
        }
      }

      response = RoverAgent.execute(agent_name, commands)

      assert response == expected_response
    end
  end

  describe "reset_coordinates/0" do
    setup do
      agent_name = :agent_reset_coordinates

      {:ok, _pid} = RoverAgent.start_link(agent_name, %{})

      %Changeset{changes: %{commands: commands}, valid?: true} = build(:commands)

      RoverAgent.execute(agent_name, commands)

      {:ok, agent_name: agent_name}
    end

    test "when called, should reset the coordinates", %{agent_name: agent_name} do
      expected_before_get_response = {
        :ok,
        %Coordinates{x: 1, y: 1, direction_index: 0}
      }

      expected_reset_response = :ok

      expected_after_get_response = {
        :ok,
        %Coordinates{x: 0, y: 0, direction_index: 0}
      }

      before_get_response = RoverAgent.get_coordinates(agent_name)
      reset_response = RoverAgent.reset_coordinates(agent_name)
      after_get_response = RoverAgent.get_coordinates(agent_name)

      assert before_get_response == expected_before_get_response
      assert reset_response == expected_reset_response
      assert after_get_response == expected_after_get_response
    end
  end
end
