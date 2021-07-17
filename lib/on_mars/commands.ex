defmodule OnMars.Commands do
  use Ecto.Schema

  import Ecto.Changeset

  @supported_commands Application.compile_env(:on_mars, [:constants, :supported_commands])

  @params [:commands]

  embedded_schema do
    field :commands, {:array, Ecto.Enum}, values: @supported_commands
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @params)
    |> custom_commands_cast_error(
      "Foram identificados comandos inválidos! Verifique os comandos enviados."
    )
  end

  defp custom_commands_cast_error(changeset, custom_error) do
    update_in(
      changeset.errors,
      fn errors ->
        case errors do
          [{:commands, {"is invalid", rules}}] -> [{:commands, {custom_error, rules}}]
          errors -> errors
        end
      end
    )
  end
end
