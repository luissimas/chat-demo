defmodule ChatDemoWeb.Components do
  use Phoenix.Component

  alias ChatDemo.Accounts.User

  attr :user, User, required: true

  def avatar(assigns) do
    ~H"""
    <div class="rounded-full w-10 h-10 bg-zinc-100 flex items-center justify-center">
      <%= if @user.avatar_url == "" do %>
        <span class="text-4xl font-bold object-center">
          <%= String.at(@user.name, 0) |> String.capitalize() %>
        </span>
      <% else %>
        <img class="w-full h-full object-contain object-center rounded-full" src={@user.avatar_url} />
      <% end %>
    </div>
    """
  end
end
