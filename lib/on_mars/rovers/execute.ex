defmodule OnMars.Rovers.Execute do
  alias Ecto.Changeset

  alias OnMars.{Commands, Error}
  alias OnMars.Rovers.Agent, as: RoverAgent

  def call(params) do
    with %Changeset{changes: %{commands: commands}, valid?: true} <- Commands.changeset(params),
         {:ok, _} = result <- RoverAgent.execute(commands) do
      result
    else
      %Changeset{valid?: false} = changeset -> {:error, Error.build(:bad_request, changeset)}
      {:error, _reason} = error -> error
    end
  end
end
