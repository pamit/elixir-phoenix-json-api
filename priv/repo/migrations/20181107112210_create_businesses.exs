defmodule BusiApi.Repo.Migrations.CreateBusinesses do
  use Ecto.Migration

  def change do
    create table(:businesses) do
      add :name, :string
      add :description, :text
      add :tag, :string

      timestamps()
    end

  end
end
