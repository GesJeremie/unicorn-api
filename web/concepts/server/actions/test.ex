defmodule Unicorn.Server.TestAction do


  use Unicorn.Concept.Action


  def run(params) do
    scrub_params(params)
  end

end
