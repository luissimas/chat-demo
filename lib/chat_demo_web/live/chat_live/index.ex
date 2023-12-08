defmodule ChatDemoWeb.ChatLive.Index do
  use ChatDemoWeb, :live_view

  alias ChatDemo.Accounts
  alias ChatDemo.Chat
  alias ChatDemo.Chat.Message
  alias ChatDemoWeb.RoomPresence

  alias Phoenix.PubSub

  @impl true
  def mount(_params, %{"user_id" => user_id}, socket) do
    user = Accounts.get_user(user_id)

    PubSub.subscribe(ChatDemo.PubSub, "chat_room")
    {:ok, _} = RoomPresence.track(self(), "chat_room", user.id, user)

    {:ok,
     socket
     |> assign(:user, user)
     |> assign(:form, to_form(Chat.change_message(%Message{})))
     |> assign(:users, list_users())
     |> stream(:messages, Chat.list_messages())}
  end

  @impl true
  def handle_event("update", %{"message" => %{"content" => content}}, socket) do
    {:noreply, assign(socket, :form, to_form(Chat.change_message(%Message{content: content})))}
  end

  @impl true
  def handle_event("send-message", %{"message" => %{"content" => content}}, socket) do
    case Chat.create_message(%{
           content: content,
           user_id: socket.assigns.user.id
         }) do
      {:ok, _message} ->
        {:noreply, assign(socket, form: to_form(Chat.change_message(%Message{})))}

      {:error, changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  @impl true
  def handle_info(%{event: "new_message", payload: message}, socket) do
    {:noreply, stream_insert(socket, :messages, message)}
  end

  @impl true
  def handle_info(%{event: "presence_diff"}, socket) do
    {:noreply, assign(socket, :users, list_users())}
  end

  defp list_users() do
    "chat_room"
    |> RoomPresence.list()
    |> Enum.flat_map(fn {_key, value} -> Map.get(value, :metas, []) end)
  end
end
