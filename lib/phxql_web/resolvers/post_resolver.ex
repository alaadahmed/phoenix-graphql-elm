defmodule PhxQLWeb.Resolvers.PostResolver do
  alias PhxQL.{Blog, Blog.Post}
  alias PhxQL.Repo

  def posts(_, _, _) do
    {:ok, Blog.list_posts()}
  end

  def create_post(_, %{input: input}, %{context: %{current_user: current_user}}) do
    post_input = Map.merge(input, %{user_id: current_user.id})
    Blog.create_post(post_input)
  end

  def delete_post(_, %{id: id}, _) do
    case Repo.get(Post, id) do
      %Post{} = post ->
        Blog.delete_post(post)

      nil ->
        {:error, "No Post Found!"}
    end
  end
end
