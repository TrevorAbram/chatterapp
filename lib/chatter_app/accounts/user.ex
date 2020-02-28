defmodule ChatterApp.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :encrypted_password, :string
    field :username, :string

    #Virtual
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true


    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :encrypted_password])
    |> validate_required([:username, :encrypted_password])
    |> validate_length(:password, min: 5)
    |> unique_constraint(:username)
  
  end
end
