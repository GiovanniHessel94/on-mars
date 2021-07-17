defmodule OnMarsWeb.ErrorView do
  use OnMarsWeb, :view

  import OnMarsWeb.ErrorHelpers, only: [translate_errors: 1]

  alias Ecto.Changeset

  # default
  def template_not_found(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def render("error.json", %{reason: %Changeset{} = changeset}) do
    %{error: translate_errors(changeset)}
  end

  def render("error.json", %{reason: reason}), do: %{error: reason}
end
