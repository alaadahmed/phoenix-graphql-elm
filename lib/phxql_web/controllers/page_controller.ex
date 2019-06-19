defmodule PhxQLWeb.PageController do
  use PhxQLWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
