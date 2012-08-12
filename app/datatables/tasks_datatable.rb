class TasksDatatable

  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: tasks.count,
      iTotalDisplayRecords: tasks.total_entries,
      aaData: data
    }
  end

private

  def data
    tasks.map do |task|
      [
        link_to(task.id, task),
        h(task.created_at),
        task.id
      ]
    end
  end

  def tasks
    @tasks ||= fetch_tasks
  end

  def fetch_tasks
    tasks=Task.order("#{sort_column} #{sort_direction}")
    tasks = tasks.page(page).per_page(per_page)
    if params[:sSearch].present?
      tasks = tasks.where("tasks.id like :search or tasks.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    tasks
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[tasks.id tasks.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
