defmodule ChatterAppWeb.PageController do
  use ChatterAppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
