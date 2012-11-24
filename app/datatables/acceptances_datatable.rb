<<<<<<< HEAD
#!/bin/env ruby
# encoding: utf-8

class AcceptancesDatatable

  delegate :params, :h, :link_to, :status ,:showpayto,to: :@view
=======
class AcceptancesDatatable

  delegate :params, :h, :link_to, :status ,to: :@view
>>>>>>> 52e895809e1fa20ec8e303d95a8774b418fd75cb

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

<<<<<<< HEAD

=======
>>>>>>> 52e895809e1fa20ec8e303d95a8774b418fd75cb
  def data
    acceptances.map do |acceptance|
      [
        link_to(status(acceptance.status), acceptance),
<<<<<<< HEAD
        h(acceptance.created_at),
        h(acceptance.in_come.money),
        showpayto(acceptance.expenditure),
        acceptance.in_come.from,      
        h(acceptance.expire),
=======
        h(acceptance.money),
        h(acceptance.bank),
        h(acceptance.expire),
        h(acceptance.created_at),
>>>>>>> 52e895809e1fa20ec8e303d95a8774b418fd75cb
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
      acceptances = acceptances.where("acceptances.bank like :search or acceptances.created_at like :search", search: "%#{params[:sSearch]}%")
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
    columns = %w[acceptances.id acceptances.money acceptances.bank acceptances.expire acceptances.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
