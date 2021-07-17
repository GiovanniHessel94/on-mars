defmodule OnMars.Rovers.Reset do
  alias OnMars.Rovers.Agent, as: RoverAgent

  def coordinates do
    with :ok <- RoverAgent.reset_coordinates() do
      {:ok, "Sonda posicionada nas coordenadas iniciais!"}
    end
  end
end
