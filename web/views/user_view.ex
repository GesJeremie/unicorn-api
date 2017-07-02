defmodule Unicorn.UserView do
  use Unicorn.Web, :view

  @attributes [:inserted_at, :updated_at]
  @attributes_create [:token, :inserted_at, :updated_at]

  def attributes(user, conn) do
    case conn.private.phoenix_action do
      :create -> Map.take(user, @attributes_create)
      _ -> Map.take(user, @attributes)
    end
  end

end