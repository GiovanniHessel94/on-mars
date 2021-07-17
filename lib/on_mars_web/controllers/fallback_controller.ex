defmodule OnMarsWeb.FallbackController do
  use OnMarsWeb, :controller

  alias OnMars.Error
  alias OnMarsWeb.ErrorView

  def call(conn, {:error, %Error{status: status, reason: reason}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", reason: reason)
  end
end
