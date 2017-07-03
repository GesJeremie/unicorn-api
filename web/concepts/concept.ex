defmodule Unicorn.Concept.Action do

  defmacro __using__(_) do
    quote do

      ###
      # When you validate data inputs in your Action
      # some business logic is involved such as:
      # 
      # 1. Perform the Validator
      # 2. Handle the result returned by the Validator:
      # 
      #     When it's a success:
      #       - Return {:ok, params}
      #   
      #     When it's an error:
      #       - Set a new flag "validation" in the params to let the 
      #         caller of the action know what went wrong
      #       - Return {:error, :name_method, params}
      # 
      # That's a lot of boilerplate which could be abstracted
      # in a single function. That's the job of validate/2.
      # 
      # Example:
      # 
      # with {:ok, params} <- validate(params, with: ShowValidation)
      # do
      #   # All good.
      # else
      #   {:error, :validate, params} ->
      #     # Something went wrong, do something.
      # end
      # 
      ###
      defp validate(params, options) do
        validator = options[:with]

        case validator.run(params) do
          {:ok, validation} ->
            {:ok, params}
          {:error, validation} ->
            params = Map.merge(params, %{validation: validation})
            {:error, :validate, params}
        end
      end

      ###
      # When you create a new record for a model in your Action
      # some business logic is involved such as:
      # 
      # 1. Perform the Query to create the new record
      # 2. Handle the result returned by the Query:
      #   
      #   When it's a success:
      #     - Set a flag "model" with the data of the record just created to let
      #       the caller of the action know what's the new created model
      #     - Return {:ok, params}
      #     
      #   When it's an error:
      #     - Set a flag "contract" with the data of the failed contract to let
      #     the caller of the action know why the contract failed
      #     - Return {:error, :name_method, params}
      #     
      # That's a lot of boilerplate which could be abstracted
      # in a single function. That's the job of model_create/2.
      # 
      # Example:
      # 
      # with {:ok, params} <- model_create(params, with: CreateQuery)
      # do
      #   # All good.
      # else
      #   {:error, :model_create, params} ->
      #     # Something went wrong, do something.
      # end
      ###
      defp model_create(params, options) do
        query = options[:with]

        case query.run(params) do
          {:ok, model} ->
            params = Map.merge(params, %{model: model})
            {:ok, params}

          {:error, contract} ->
            params = Map.merge(params, %{contract: contract})
            {:error, :model_create, params}
        end
      end

      ###
      # When you try to find a record for a model in your Action
      # some business logic is involved such as:
      # 
      # 1. Perform the Query to find the record/records
      # 2. Handle the result returned by the Query:
      #   
      #   When we found the record/records:
      #     - Set a flag "model" with the data of the record/records found to let
      #       the caller of the action know about them
      #     - Return {:ok, params}
      #     
      #   When no record/records found (nil):
      #     - Return {:error, :name_method, params}
      #     
      # That's a lot of boilerplate which could be abstracted
      # in a single function. That's the job of model_find/2.
      # 
      # Example:
      # 
      # with {:ok, params} <- model_find(params, with: FindByNameQuery)
      # do
      #   # All good.
      # else
      #   {:error, :model_find, params} ->
      #     # Something went wrong, do something.
      # end
      ###
      defp model_find(params, options) do
        getter = options[:with]

        case getter.run(params) do
          nil ->
            {:error, :model_find, params}

          model ->
            params = Map.merge(params, %{model: model})
            {:ok, params}
        end
      end

      ###
      # Taken from Phoenix scrub_params, replace empty strings
      # values to nil.
      # 
      # Example: 
      # 
      # scrub_params((%{firstname: " ", lastname: "guess", attributes: %{zipcode: ""}})
      # 
      # -> %{firstname: nil, lastname: "guess", attributes: %{zipcode: nil}})
      # 
      ###
      def scrub_params(params) do
        scrub_param(params)
      end

      defp scrub_param(%{__struct__: mod} = struct) when is_atom(mod) do
        struct
      end
      defp scrub_param(%{} = param) do
        Enum.reduce(param, %{}, fn({k, v}, acc) ->
          Map.put(acc, k, scrub_param(v))
        end)
      end
      defp scrub_param(param) when is_list(param) do
        Enum.map(param, &scrub_param/1)
      end
      defp scrub_param(param) do
        if scrub?(param), do: nil, else: param
      end

      defp scrub?(" " <> rest), do: scrub?(rest)
      defp scrub?(""), do: true
      defp scrub?(_), do: false

      defoverridable [validate: 2, model_create: 2, model_find: 2]

    end
  end

end

defmodule Unicorn.Concept.Validation do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset

      def run(params) do
        validation = validate(params)

        if validation.valid? do
          {:ok, validation}
        else
          {:error, validation}
        end
      end

      defp cast_as do
        %{}
      end

      defp validate(params \\ %{}) do
        {%{}, cast_as()}
        |> cast(params, Map.keys(cast_as()))
        |> validations
      end

      defp validations(changeset) do
        changeset
      end

      defoverridable [run: 1, cast_as: 0, validate: 0, validate: 1, validations: 1]
    end
  end
end

defmodule Unicorn.Concept.Query do
  defmacro __using__(_) do
    quote do
      alias Unicorn.Repo
      import Ecto
      import Ecto.Query
    end
  end
end

defmodule Unicorn.Concept.Contract do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
    end
  end
end





