defmodule ChatDemoWeb.RoomLive do
  use ChatDemoWeb, :live_view

  alias ChatDemo.Accounts

  def render(assigns) do
    ~H"""
    <div>
      <h1>Welcome <%= @user.name %>! <img width="128px" src={@user.avatar_url} /></h1>
      <p>
        You are <strong>signed in</strong> with your <strong><%= @user.provider %> account</strong>
      </p>
      <p><strong style="color:teal;"><%= @user.email %></strong></p>
      <p><.link href="/auth/logout">Logout</.link></p>
    </div>
    """
  end

  def mount(_params, %{"user_id" => user_id}, socket) do
    user = Accounts.get_user(user_id)
    {:ok, assign(socket, :user, user)}
  end
end
