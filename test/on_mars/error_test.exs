defmodule OnMars.ErrorTest do
  use ExUnit.Case

  alias OnMars.Error

  describe "build/2" do
    test "when the params are given, returns an error struct" do
      status = :bad_request
      reason = "Razão"

      expected_response = %Error{status: :bad_request, reason: "Razão"}

      response = Error.build(status, reason)

      assert response == expected_response
    end
  end
end
