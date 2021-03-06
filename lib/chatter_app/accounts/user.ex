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
    |> validate_confirmation(:password)
    |> validate_length(:username, min: 5)
    |> validate_format(:username, ~r/^[a-z0-9][a-z0-9]+[a-z0-9]$/i)
    |> unique_constraint(:username)
    |> downcase_username
    |> encrypt_password
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :password)
    if password do
      encrypted_password = Encryption.hash_password(password)
      put_change(changeset, encrypted_password, :encrypted_password)
    else changeset
    end
  end

  defp downcase_username(changeset) do
    update_change(changeset, :username, &String.downcase/1)

  end


end
