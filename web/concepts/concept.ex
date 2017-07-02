defmodule Unicorn.Concept do
  def action do
    quote do
      alias Unicorn.Concept.Action
    end  
  end

  def query do
    quote do
      alias Unicorn.Repo
      import Ecto
      import Ecto.Query
    end
  end

  def contract do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
    end
  end

  def validation do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end


defmodule Unicorn.Concept.Action do

  def validate(params, options) do
    validator = options[:with]

    case validator.run(params) do
      {:ok, validation} ->
        {:ok, params}
      {:error, validation} ->
        params = Map.merge(params, %{validation: validation})
        {:error, :validate, params}
    end
  end

  def create(params, options) do
    saver = options[:with]

    case saver.run(params) do
      {:ok, model} ->
        params = Map.merge(params, %{model: model})
        {:ok, params}

      {:error, contract} ->
        params = Map.merge(params, %{contract: contract})
        {:error, :save, params}
    end
  end

  def show(params, options) do
    getter = options[:with]

    case getter.run(params) do
      nil ->
        {:error, :show, params}

      model ->
        params = Map.merge(params, %{model: model})
        {:ok, params}
    end
  end

end

defmodule Unicorn.Concept.Validation do
end

defmodule Unicorn.Concept.Query do
  
end

defmodule Unicorn.Concept.Contract do
  
end






