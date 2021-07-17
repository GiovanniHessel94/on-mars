defmodule OnMarsWeb.RoversControllerTest do
  use OnMarsWeb.ConnCase, async: true

  import OnMars.Factory

  describe "execute/2" do
    test "when all params are valid, returns the execution response", %{conn: conn} do
      params = build(:commands_params)

      response =
        conn
        |> post("/api/rovers/execute", params)
        |> json_response(:ok)

      assert %{
               "message" => "Comandos executados com sucesso!",
               "data" => %{
                 "x" => _x,
                 "y" => _y
               }
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      params = build(:commands_params, %{"commands" => ["N"]})

      expected_response = %{
        "error" => %{
          "commands" => [
            "Foram identificados comandos inválidos! Verifique os comandos enviados."
          ]
        }
      }

      response =
        conn
        |> post("/api/rovers/execute", params)
        |> json_response(:bad_request)

      assert response == expected_response
    end

    test "when the commands cannot be executed, return an error", %{conn: conn} do
      params = build(:commands_params, %{"commands" => ["M", "M", "M", "M", "M", "M"]})

      expected_response = %{
        "error" => "A sonda detectou que essa série de comandos não pode ser executada!"
      }

      response =
        conn
        |> post("/api/rovers/execute", params)
        |> json_response(:bad_request)

      assert response == expected_response
    end
  end

  describe "show/2" do
    test "when called, should get the coordinates", %{conn: conn} do
      response =
        conn
        |> get("/api/rovers/coordinates")
        |> json_response(:ok)

      assert %{
               "message" => "Coordenatas obtidas com sucesso!",
               "data" => %{
                 "x" => _x,
                 "y" => _y,
                 "direction" => _direction
               }
             } = response
    end
  end

  describe "reset/2" do
    test "when called, should reset the coordinates", %{conn: conn} do
      expected_response = ""

      response =
        conn
        |> put("/api/rovers/reset")
        |> response(:no_content)

      assert response == expected_response
    end
  end
end
