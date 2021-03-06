defmodule Unicorn.Web do
  @moduledoc """
  A module that keeps using definitions for controllers,
  views and so on.

  This can be used in your application as:

      use Unicorn.Web, :controller
      use Unicorn.Web, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below.
  """
  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Query

      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type Ecto.UUID
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias Unicorn.Repo
      import Ecto
      import Ecto.Query

      import Unicorn.Router.Helpers
      import Unicorn.Gettext
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"
      use JaSerializer.PhoenixView

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2, view_module: 1]

      import Unicorn.Router.Helpers
      import Unicorn.ErrorHelpers
      import Unicorn.Gettext
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel

      alias Unicorn.Repo
      import Ecto
      import Ecto.Query
      import Unicorn.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
