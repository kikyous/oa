class ReimbursementsDatatable

  delegate :params, :h, :link_to, :debts_status ,to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: reimbursements.count,
      iTotalDisplayRecords: reimbursements.total_entries,
      aaData: data
    }
  end

private

  def data
    reimbursements.map do |reimbursement|
      [
        link_to(debts_status(reimbursement.status), reimbursement),
        h(reimbursement.user.username),
        h(reimbursement.category),
        h(reimbursement.money),
        h(reimbursement.created_at),
        reimbursement.id
      ]
    end
  end

  def reimbursements
    @reimbursements ||= fetch_reimbursements
  end

  def fetch_reimbursements
    reimbursements=Reimbursement.order("#{sort_column} #{sort_direction}")
    reimbursements = reimbursements.page(page).per_page(per_page)
    if params[:sSearch].present?
      reimbursements = reimbursements.where("reimbursements.id like :search or reimbursements.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    reimbursements
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[reimbursements.id reimbursements.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
