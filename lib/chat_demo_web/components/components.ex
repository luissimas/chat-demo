defmodule ChatDemoWeb.Components do
  use Phoenix.Component

  alias ChatDemo.Accounts.User

  attr :user, User, required: true

  def avatar(assigns) do
    ~H"""
    <div class="rounded-full w-10 h-10 bg-zinc-100 flex items-center justify-center min-w-max">
      <%= if has_avatar_url(@user) do %>
        <img class="w-full h-full object-contain object-center rounded-full" src={@user.avatar_url} />
      <% else %>
        <span class="text-2xl font-bold object-center">
          <%= String.at(@user.name, 0) |> String.capitalize() %>
        </span>
      <% end %>
    </div>
    """
  end

  defp has_avatar_url(%User{avatar_url: avatar_url}) when is_nil(avatar_url), do: false

  defp has_avatar_url(%User{avatar_url: avatar_url}) do
    len =
      avatar_url
      |> String.trim()
      |> String.length()

    len != 0
  end

  def message(assigns) do
    ~H"""
    <div class="flex flex-col mb-2">
      <div class="flex items-center">
        <ChatDemoWeb.Components.avatar user={@message.user} />
        <div class="px-2">
          <div class="flex items-center text-gray-900">
            <div>
              <p class="font-semibold"><%= @message.user.name %></p>
              <time class="text-gray-500 text-sm"><%= format_date(@message.inserted_at) %></time>
            </div>
          </div>
        </div>
      </div>
      <div class="px-2 pb-2">
        <p class="text-gray-800"><%= @message.content %></p>
      </div>
    </div>
    """
  end

  defp format_date(time) do
    # NOTE: we certainly shouldn't convert the date to user's local timezone
    # on the server side, but this will serve our demo purposes
    time
    |> Timex.Timezone.convert("UTC")
    |> Timex.Timezone.convert("America/Sao_Paulo")
    |> Timex.format!("%d/%m/%Y %H:%M", :strftime)
  end
end
