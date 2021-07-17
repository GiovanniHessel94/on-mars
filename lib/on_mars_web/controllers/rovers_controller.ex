defmodule OnMarsWeb.RoversController do
  use OnMarsWeb, :controller

  alias OnMars.Coordinates

  alias OnMarsWeb.FallbackController

  action_fallback FallbackController

  def execute(conn, params) do
    with {:ok, result} <- OnMars.execute_rover_commands(params) do
      conn
      |> put_status(:ok)
      |> render("execute.json", result: result)
    end
  end

  def show(conn, _params) do
    with {:ok, %Coordinates{} = result} <- OnMars.get_rover_coordinates() do
      conn
      |> put_status(:ok)
      |> render("show.json", result: result)
    end
  end

  def reset(conn, _params) do
    with {:ok, _result} <- OnMars.reset_rover_coordinates() do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end
end
