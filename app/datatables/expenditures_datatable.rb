class ExpendituresDatatable

  delegate :params, :h, :link_to, :mode ,to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: expenditures.count,
      iTotalDisplayRecords: expenditures.total_entries,
      aaData: data
    }
  end

private

  def data
    expenditures.map do |expenditure|
      [
        link_to(mode(expenditure.mode), expenditure),
        h(expenditure.money),
        h(expenditure.created_at),
        expenditure.id
      ]
    end
  end

  def expenditures
    @expenditures ||= fetch_expenditures
  end

  def fetch_expenditures
    expenditures=Expenditure.order("#{sort_column} #{sort_direction}")
    expenditures = expenditures.page(page).per_page(per_page)
    if params[:sSearch].present?
      expenditures = expenditures.where("expenditures.id like :search or expenditures.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    expenditures
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[expenditures.id expenditures.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
