defmodule Sandbox.UserController do
  use Sandbox.Web, :controller

  alias Sandbox.User

  plug :authenticate when action in [:index, :show]

  def index(conn, _params) do
    render conn, "index.html", users: Repo.all(Sandbox.User)
  end

  def show(conn, params) do
    render conn, "show.html", user: Repo.get(Sandbox.User, Map.get(params, "id"))
  end

  def new(conn, _params) do
    render conn, "new.html", changeset: User.changeset(%User{})
  end

  def create(conn, %{"user" => params}) do
    changeset = User.authentication_changeset(%User{}, params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> Sandbox.Authentication.signin(user)
        |> put_flash(:info, "#{user.email} created!")
        |> redirect(to: user_path(conn, :index))
     {:error, changeset} ->
       render(conn, "new.html", changeset: changeset)
    end
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: page_path(conn, :index))
      |> halt()
    end
  end
end
