class InComesDatatable

  delegate :params, :h, :link_to, :mode ,to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: in_comes.count,
      iTotalDisplayRecords: in_comes.total_entries,
      aaData: data
    }
  end

private

  def data
    in_comes.map do |in_come|
      [
        link_to(mode(in_come.mode), in_come),
        h(in_come.money),
        h(in_come.created_at),
        in_come.id
      ]
    end
  end

  def in_comes
    @in_comes ||= fetch_in_comes
  end

  def fetch_in_comes
    in_comes=InCome.order("#{sort_column} #{sort_direction}")
    in_comes = in_comes.page(page).per_page(per_page)
    if params[:sSearch].present?
      in_comes = in_comes.where("in_comes.id like :search or in_comes.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    in_comes
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[in_comes.id in_comes.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
