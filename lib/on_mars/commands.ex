defmodule OnMars.Commands do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @supported_commands Application.compile_env(:on_mars, [:constants, :supported_commands])

  @params [:commands]

  @invalid_commands_msg "Foram identificados comandos inválidos! Verifique os comandos enviados."
  @commands_required_msg "A lista de comandos é obrigatória e deve conter um ou mais comandos! Verifique o corpo da requisição."

  embedded_schema do
    field :commands, {:array, Ecto.Enum}, values: @supported_commands
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @params)
    |> custom_handle_cast_error()
    |> custom_validate_commands_required()
  end

  defp custom_handle_cast_error(changeset) do
    update_in(
      changeset.errors,
      fn errors ->
        case errors do
          [{:commands, {"is invalid", rules}}] -> [{:commands, {@invalid_commands_msg, rules}}]
          errors -> errors
        end
      end
    )
  end

  defp custom_validate_commands_required(%Changeset{valid?: true} = changeset) do
    commands = get_change(changeset, :commands, [])

    case Enum.empty?(commands) do
      false -> changeset
      true -> add_error(changeset, :commands, @commands_required_msg)
    end
  end

  defp custom_validate_commands_required(%Changeset{valid?: false} = changeset), do: changeset
end
