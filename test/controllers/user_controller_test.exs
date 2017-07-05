defmodule Unicorn.UserControllerTest do
  use Unicorn.ConnCase, async: true

  @create_attributes ["token", "inserted-at", "updated-at"]
  @show_attributes ["inserted-at", "updated-at"]

  test "create renders user object with token" do
    conn = build_conn()
    conn = post conn, "/v1/users"

    response = json_response(conn, :created)
    attributes = get_response_attributes(response)

    assert has_attributes?(attributes, @create_attributes)
  end

  test "show renders user object without token" do
    {:ok, %{:model => user}} = Unicorn.User.CreateAction.run()

    conn = build_conn()
    conn = get conn, user_path(conn, :show, user.id)

    response = json_response(conn, 200)
    attributes = get_response_attributes(response)

    assert has_attributes?(attributes, @show_attributes)
    assert !"token" in attributes  
  end

  def has_attributes?(attributes, required_attributes) do
    Enum.all?(attributes, fn(attribute) -> 
      attribute in required_attributes
    end)
  end

  def get_response_attributes(response) do
    Map.keys(response["data"]["attributes"])
  end

end
