defmodule ChatDemo.ChatFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ChatDemo.Chat` context.
  """

  @doc """
  Generate a message.
  """
  def message_fixture(attrs \\ %{}) do
    user = ChatDemo.AccountFixtures.user_fixture()

    {:ok, message} =
      attrs
      |> Enum.into(%{
        content: "some content",
        user_id: user.id
      })
      |> ChatDemo.Chat.create_message()

    message
  end
end
