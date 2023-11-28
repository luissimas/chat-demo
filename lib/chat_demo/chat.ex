defmodule ChatDemo.Chat do
  @moduledoc """
  The Chat context.
  """

  import Ecto.Query, warn: false
  alias ChatDemo.Repo

  alias ChatDemo.Chat.Message

  alias Phoenix.PubSub
  alias Phoenix.Socket.Broadcast

  @doc """
  Returns the list of messages.

  ## Examples

      iex> list_messages()
      [%Message{}, ...]

  """
  def list_messages do
    Message
    |> Repo.all()
    |> Repo.preload(:user)
  end

  @doc """
  Creates a message. And broadcasts it to the chat room.

  ## Examples

      iex> create_message(%{field: value})
      {:ok, %Message{}}

      iex> create_message(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_message(attrs \\ %{}) do
    insert_result =
      %Message{}
      |> Message.changeset(attrs)
      |> Repo.insert()

    with {:ok, message} <- insert_result do
      message = Repo.preload(message, :user)

      PubSub.broadcast(ChatDemo.PubSub, "chat_room", %Broadcast{
        event: "new_message",
        payload: message,
        topic: "chat_room"
      })

      {:ok, message}
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking message changes.

  ## Examples

      iex> change_message(message)
      %Ecto.Changeset{data: %Message{}}

  """
  def change_message(%Message{} = message, attrs \\ %{}) do
    Message.changeset(message, attrs)
  end
end
