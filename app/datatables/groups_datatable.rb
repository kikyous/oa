class GroupsDatatable
  delegate :params, :h, :link_to ,:edit_group_path, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Group.count,
      iTotalDisplayRecords: groups.total_entries,
      aaData: data
    }
  end

private

  def data
    groups.map do |group|
      [
        link_to(group.id, edit_group_path(group)),
        h(group.name),
        group.created_at,
        group.id
      ]
    end
  end

  def groups
    @groups ||= fetch_groups
  end

  def fetch_groups
    groups = Group.order("#{sort_column} #{sort_direction}")
    groups = groups.page(page).per_page(per_page)
    if params[:sSearch].present?
      groups = groups.where("groups.name like :search or groups.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    groups
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[groups.id groups.name groups.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
