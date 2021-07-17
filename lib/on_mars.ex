defmodule OnMars do
  alias OnMars.Rovers.Execute, as: RoverExecute
  alias OnMars.Rovers.Get, as: RoverGet
  alias OnMars.Rovers.Reset, as: RoverReset

  defdelegate execute_rover_commands(params), to: RoverExecute, as: :call
  defdelegate get_rover_coordinates, to: RoverGet, as: :coordinates
  defdelegate reset_rover_coordinates, to: RoverReset, as: :coordinates
end
