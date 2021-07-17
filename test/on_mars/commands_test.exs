defmodule OnMars.CommandsTest do
  use ExUnit.Case

  import OnMars.Factory

  alias Ecto.Changeset

  alias OnMars.Commands

  describe "changeset/1" do
    test "when all commands are valid, returns an valid changeset" do
      params = build(:commands_params)

      response = Commands.changeset(params)

      assert %Changeset{changes: %{commands: [:M, :GE, :M, :GD]}, valid?: true} = response
    end

    test "when there are invalid commands, returns an invalid changeset" do
      params = build(:commands_params, %{"commands" => ["GG"]})

      response = Commands.changeset(params)

      assert %Changeset{
               errors: [
                 commands:
                   {"Foram identificados comandos inválidos! Verifique os comandos enviados.",
                    _rules}
               ],
               valid?: false
             } = response
    end
  end
end
