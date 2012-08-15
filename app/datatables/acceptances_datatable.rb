class AcceptancesDatatable

  delegate :params, :h, :link_to, :status ,to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: acceptances.count,
      iTotalDisplayRecords: acceptances.total_entries,
      aaData: data
    }
  end

private

  def data
    acceptances.map do |acceptance|
      [
        link_to(status(acceptance.status), acceptance),
        h(acceptance.money),
        h(acceptance.bank),
        h(acceptance.expire),
        h(acceptance.created_at),
        acceptance.id
      ]
    end
  end

  def acceptances
    @acceptances ||= fetch_acceptances
  end

  def fetch_acceptances
    acceptances=Acceptance.order("#{sort_column} #{sort_direction}")
    acceptances = acceptances.page(page).per_page(per_page)
    if params[:sSearch].present?
      acceptances = acceptances.where("acceptances.id like :search or acceptances.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    acceptances
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[acceptances.id acceptances.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
