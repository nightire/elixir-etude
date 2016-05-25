defmodule Sandbox.User do
  use Sandbox.Web, :model

  schema "users" do
    field :email,         :string
    field :username,      :string
    field :password,      :string, virtual: true
    field :password_hash, :string

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:email, :username], [])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:username, min: 4, max: 20)
  end

  def authentication_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, [:password], [])
    |> validate_length(:password, min: 6, max: 128)
    |> push_hash_password()
  end

  defp push_hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset,
                   :password_hash,
                   Comeonin.Bcrypt.hashpwsalt(password))
      _ -> changeset
    end
  end
end
