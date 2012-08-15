class UnpaidDebtsDatatable

  delegate :params, :h, :link_to, :debts_status ,to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: unpaid_debts.count,
      iTotalDisplayRecords: unpaid_debts.total_entries,
      aaData: data
    }
  end

private

  def data
    unpaid_debts.map do |unpaid_debt|
      [
        link_to(debts_status(unpaid_debt.status), unpaid_debt),
        h(unpaid_debt.group.name),
        h(unpaid_debt.money),
        h(unpaid_debt.created_at),
        unpaid_debt.id
      ]
    end
  end

  def unpaid_debts
    @unpaid_debts ||= fetch_unpaid_debts
  end

  def fetch_unpaid_debts
    unpaid_debts=UnpaidDebt.order("#{sort_column} #{sort_direction}")
    unpaid_debts = unpaid_debts.page(page).per_page(per_page)
    if params[:sSearch].present?
      unpaid_debts = unpaid_debts.where("unpaid_debts.id like :search or unpaid_debts.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    unpaid_debts
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[unpaid_debts.id unpaid_debts.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
