defmodule ChatDemo.Repo do
  use Ecto.Repo,
    otp_app: :chat_demo,
    adapter: Ecto.Adapters.Postgres
end
