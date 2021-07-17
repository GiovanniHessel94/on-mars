defmodule OnMars.Coordinates do
  alias OnMars.Error

  @keys [:x, :y, :direction_index]

  @enforce_keys @keys

  @directions %{0 => "D", 1 => "B", 2 => "E", 3 => "C"}

  defstruct @keys

  def build(x, y, direction_index)
      when is_number(x) and is_number(y) and direction_index >= 0 and direction_index <= 3 do
    {:ok, %__MODULE__{x: x, y: y, direction_index: direction_index}}
  end

  def build(_x, _y, _direction_index) do
    {:error, Error.build(:bad_request, "Parâmetros de cooordenada inválidos")}
  end

  def to_map_response(%__MODULE__{x: x, y: y, direction_index: direction_index}) do
    direction = Map.get(@directions, direction_index)

    %{x: x, y: y, direction: direction}
  end
end
