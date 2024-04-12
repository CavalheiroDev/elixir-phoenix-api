defmodule UsersPhoenixWeb.UserJSON do
  alias UsersPhoenix.Users.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{results: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a create user.
  """
  def create(%{user: user, token: token}) do
    data(user, token)
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    data(user)
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email
    }
  end

  defp data(%User{} = user, token) do
    %{
      id: user.id,
      email: user.email,
      token: token
    }
  end
end
