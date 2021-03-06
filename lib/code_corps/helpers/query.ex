defmodule CodeCorps.Helpers.Query do
  import CodeCorps.Helpers.String, only: [coalesce_id_string: 1, coalesce_string: 1]
  import Ecto.Query, only: [where: 3, limit: 2, order_by: 2]

  def id_filter(query, id_list) do
    ids = id_list |> coalesce_id_string
    query |> where([object], object.id in ^ids)
  end

  # skill queries

  def limit_filter(query, %{"limit" => count}) do
    query |> limit(^count)
  end
  def limit_filter(query, _), do: query

  def title_filter(query, %{"query" => title}) do
    query |> where([object], ilike(object.title, ^"%#{title}%"))
  end
  def title_filter(query, _), do: query

  # end skill queries

  # task queries

  def project_id_with_number_filter(query, %{"id" => number, "project_id" => project_id}) do
    query |> where([object], object.number == ^number and object.project_id == ^project_id)
  end
  def project_id_with_number_filter(query, _), do: query

  def project_filter(query, %{"project_id" => project_id}) do
    query |> where([object], object.project_id == ^project_id)
  end
  def project_filter(query, _), do: query

  def task_type_filter(query, %{"task_type" => task_type_list}) do
    task_types = task_type_list |> coalesce_string
    query |> where([object], object.task_type in ^task_types)
  end
  def task_type_filter(query, _), do: query

  def task_status_filter(query, %{"status" => status}) do
    query |> where([object], object.status == ^status)
  end
  def task_status_filter(query, _), do: query

  # end task queries

  # def comment queries

  def task_filter(query, task_id) do
    query |> where([object], object.task_id == ^task_id)
  end

  # end comment queries

  # sorting

  def sort_by_newest_first(query), do: query |> order_by([desc: :inserted_at])

  # end sorting

  # finders

  def slug_finder(query, slug) do
    query |> CodeCorps.Repo.get_by(slug: slug |> String.downcase)
  end

  # end finders
end
