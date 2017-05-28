defmodule Unicorn.ServerView do
  use Unicorn.Web, :view

  attributes [:id, :name, :token, :inserted_at, :updated_at]

end