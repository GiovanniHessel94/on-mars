defmodule OnMarsWeb.ErrorViewTest do
  use OnMarsWeb.ConnCase, async: true

  import Phoenix.View

  import OnMars.Factory

  alias Ecto.Changeset

  alias OnMars.Commands

  alias OnMarsWeb.ErrorView

  test "renders 404.json" do
    expected_response = %{errors: %{detail: "Not Found"}}

    response = render(ErrorView, "404.json", [])

    assert response == expected_response
  end

  test "renders 500.json" do
    expected_response = %{errors: %{detail: "Internal Server Error"}}

    response = render(ErrorView, "500.json", [])

    assert response == expected_response
  end

  test "renders error.json with a simple error" do
    expected_response = %{error: "Razão"}

    response = render(ErrorView, "error.json", %{reason: "Razão"})

    assert response == expected_response
  end

  test "renders error.json with a changeset error" do
    changeset_error =
      :commands_params
      |> build(%{"commands" => "N"})
      |> Commands.changeset()

    expected_response = %{
      error: %{
        commands: ["Foram identificados comandos inválidos! Verifique os comandos enviados."]
      }
    }

    response = render(ErrorView, "error.json", %{reason: changeset_error})

    assert %Changeset{valid?: false} = changeset_error
    assert response == expected_response
  end
end
