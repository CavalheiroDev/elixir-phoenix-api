defmodule UsersPhoenix.Repo do
  use Ecto.Repo,
    otp_app: :users_phoenix,
    adapter: Ecto.Adapters.Postgres
end
