defmodule ChatDemo.ChatTest do
  use ChatDemo.DataCase

  alias ChatDemo.Chat

  describe "messages" do
    alias ChatDemo.Chat.Message

    import ChatDemo.ChatFixtures
    import ChatDemo.AccountFixtures

    @invalid_attrs %{content: nil, user_id: nil}

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Chat.list_messages() == [message]
    end

    test "create_message/1 with valid data creates a message" do
      user = user_fixture()
      valid_attrs = %{content: "some content", user_id: user.id}

      assert {:ok, %Message{} = message} = Chat.create_message(valid_attrs)
      assert message.content == "some content"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_message(@invalid_attrs)
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Chat.change_message(message)
    end
  end
end
