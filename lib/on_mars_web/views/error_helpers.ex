defmodule OnMarsWeb.ErrorHelpers do
  import Ecto.Changeset, only: [traverse_errors: 2]

  alias Ecto.Changeset

  def translate_errors(%Changeset{} = changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", translate_value(value))
      end)
    end)
  end

  defp translate_value({:array, {:parameterized, Ecto.Enum, _map}}), do: ""
  defp translate_value(value), do: to_string(value)
end
