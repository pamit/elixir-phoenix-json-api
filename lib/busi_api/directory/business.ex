defmodule BusiApi.Directory.Business do
  use Ecto.Schema
  import Ecto.Changeset


  schema "businesses" do
    field :description, :string
    field :name, :string
    field :tag, :string

    timestamps()
  end

  @doc false
  def changeset(business, attrs) do
    business
    |> cast(attrs, [:name, :description, :tag])
    |> validate_required([:name, :description, :tag])
  end
end
