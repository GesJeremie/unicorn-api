defmodule Unicorn.Concept.Action do

  defmacro __using__(_) do
    quote do

      defp init_options(params) do
        %{params: scrub_params(params)}
      end

      defp validate(options, params) do
        validator = params[:with]
        error_key = params[:error_key] || :validate
        option_key = params[:option_key] || :validation

        case validator.run(options) do
          {:ok, validation} ->
            {:ok, options}
          {:error, validation} ->
            data = Map.put(%{}, option_key, validation)
            options = Map.merge(options, data)
            {:error, error_key, options}
        end
      end

      defp model(:create, options, params) do
        creator = params[:with]
        error_key = params[:error_key] || :model_create
        option_key = params[:option_key] || :model
        option_error_key = params[:option_error_key] || :contract

        case creator.run(options) do
          {:ok, model} ->
            data = Map.put(%{}, option_key, model)
            options = Map.merge(options, data)
            {:ok, options}

          {:error, contract} ->
            data = Map.put(%{}, option_error_key, contract)
            options = Map.merge(options, data)
            {:error, :error_key, options}
        end
      end

      defp model(:find, options, params) do
        finder = params[:with]
        error_key = params[:error_key] || :model_find
        option_key = params[:option_key] || :model

        case finder.run(options) do
          nil ->
            {:error, error_key, options}

          model ->
            data = Map.put(%{}, option_key, model)
            options = Map.merge(options, data)
            {:ok, options}
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

    end
  end

end

defmodule Unicorn.Concept.Validation do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset

      def run(options) do
        params = params(options)
        IO.inspect params
        validation = 
          {%{}, params_types()}
          |> cast(params, Map.keys(params_types()))
          |> rules
          |> valid?
      end

      defp params(options) do
        %{}
      end

      defp params_types do
        %{}
      end

      defp rules(changeset) do
        changeset
      end

      defp valid?(validation) do
        if validation.valid? do
          {:ok, validation}
        else
          {:error, validation}
        end
      end

      defoverridable [run: 1, params: 1, params_types: 0, rules: 1, valid?: 1]
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





