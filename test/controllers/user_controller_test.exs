defmodule Unicorn.UserControllerTest do
  use Unicorn.ConnCase, async: true

  test "create renders user object with token" do
    conn = build_conn()

    conn = post conn, user_path(conn, :create)

    response = json_response(conn, :created)

    IO.puts "here"
    IO.inspect response["data"]["attributes"]


    assert json_response(conn, :created) 
    """
    assert json_response(conn, 200) == %{
      "todos" => [%{
          "title" => todo.title,
          "description" => todo.description,
          "inserted_at" => Ecto.DateTime.to_iso8601(todo.inserted_at),
          "updated_at" => Ecto.DateTime.to_iso8601(todo.updated_at)
        }]
      }
    """
  end

  test "show renders user object without token" do
    
  end

end
