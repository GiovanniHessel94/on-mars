defmodule OnMars.Rovers.ExecuteTest do
  use ExUnit.Case

  import OnMars.Factory

  alias Ecto.Changeset

  alias OnMars.{Coordinates, Error}
  alias OnMars.Rovers.Execute

  describe "call/1" do
    test "when all params are valid, returns the execution result" do
      params = build(:commands_params)

      response = Execute.call(params)

      assert {:ok, %Coordinates{}} = response
    end

    test "when there are invalid params, returns an error" do
      params = build(:commands_params, %{"commands" => ["N"]})

      response = Execute.call(params)

      assert {
               :error,
               %Error{
                 status: :bad_request,
                 reason: %Changeset{valid?: false}
               }
             } = response
    end

    test "when the commands cannot be executed, return an error" do
      params = build(:commands_params, %{"commands" => ["M", "M", "M", "M", "M", "M"]})

      response = Execute.call(params)

      assert {
               :error,
               %Error{
                 status: :bad_request,
                 reason: "A sonda detectou que essa série de comandos não pode ser executada!"
               }
             } = response
    end
  end
end
