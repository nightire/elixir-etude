defmodule Sandbox.UserView do
  use Sandbox.Web, :view
  alias Sandbox.User

  def display_name(%User{username: username}) do
    username
    |> String.upcase
  end
end
