defmodule Weather.Airports.Airport do
  use Ecto.Schema
  import Ecto.Changeset
  alias Weather.Airports.Airport


  schema "airports" do
    field :code, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%Airport{} = airport, attrs) do
    airport
    |> cast(attrs, [:name, :code])
    |> validate_required([:name, :code])
  end
end
