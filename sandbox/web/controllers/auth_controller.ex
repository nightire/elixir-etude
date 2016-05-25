defmodule Sandbox.AuthController do
  use Sandbox.Web, :controller

  import Sandbox.Authentication, only: [check_credential: 3]

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"credential" => credential}) do
    case check_credential(conn, credential, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid credential(username/password) combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Sandbox.Authentication.signout()
    |> redirect(to: page_path(conn, :index))
  end
end
