defmodule Unicorn.Server.CreateAction do

  """
  use Unicorn.Concept.Action

  alias Unicorn.Server.{
    NameExistsQuery,
    UserExistsQuery,
    CreateQuery,
    CreateValidation
  }

  def run(params \\ %{}) do
    params = scrub_params(params)

    with {:ok, params} <- validate(params, with: CreateValidation),
         {:ok, params} <- model_find(params, with: UserExistsQuery),
         {:ok, params} <- fetch_or_create_name(params),
         {:ok, params} <- model_create(params, with: CreateQuery)
    do
      {:ok, params}
    else
      {:error, method, params} ->
        {:error, method, params}
    end
  end

  defp fetch_or_create_name(params) do
    name = 
      if Map.has_key?(params, :name) and params[:name] !== nil do
        Slugger.slugify_downcase(params[:name])
      else
        # Generate name
        Unicorn.Server.Helpers.generate_unique_name
      end

    params = Map.merge(params, %{name: name})

    {:ok, params}
  end
  """

end