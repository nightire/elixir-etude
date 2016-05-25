defmodule Sandbox.Router do
  use Sandbox.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Sandbox.Authentication, repo: Sandbox.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Sandbox do
    pipe_through :browser # Use the default browser stack

    get "/",            PageController, :index
    resources "/auth",  AuthController, only: [:new, :create, :delete]
    resources "/users", UserController, only: [:index, :show, :new, :create]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Sandbox do
  #   pipe_through :api
  # end
end
