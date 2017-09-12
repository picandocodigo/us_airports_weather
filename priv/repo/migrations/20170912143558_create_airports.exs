defmodule Weather.Repo.Migrations.CreateAirports do
  use Ecto.Migration

  def change do
    create table(:airports) do
      add :name, :string
      add :code, :string

      timestamps()
    end

  end
end
