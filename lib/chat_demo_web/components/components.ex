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

  def message(assigns) do
    # NOTE: we certainly shouldn't convert the date to user's local timezone
    # on the server side, but this will serve our demo purposes
    time =
      assigns.message.inserted_at
      |> Timex.Timezone.convert("UTC")
      |> Timex.Timezone.convert("America/Sao_Paulo")
      |> Timex.format!("%d/%m/%Y %H:%M", :strftime)

    assign(assigns, time: time)

    ~H"""
    <div class="flex flex-col mb-2">
      <div class="flex items-center">
        <ChatDemoWeb.Components.avatar user={@message.user} />
        <div class="px-2">
          <div class="flex items-center text-gray-900">
            <div>
              <p class="font-semibold"><%= @message.user.name %></p>
              <time class="text-gray-500 text-sm"><%= @time %></time>
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
end
