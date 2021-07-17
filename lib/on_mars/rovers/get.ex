defmodule OnMars.Rovers.Get do
  alias OnMars.Coordinates
  alias OnMars.Rovers.Agent, as: RoverAgent

  def coordinates do
    with {:ok, %Coordinates{}} = result <- RoverAgent.get_coordinates() do
      result
    end
  end
end
