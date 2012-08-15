class TransfersDatatable

  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: transfers.count,
      iTotalDisplayRecords: transfers.total_entries,
      aaData: data
    }
  end

private

  def data
    transfers.map do |transfer|
      [
        link_to(transfer.id, transfer),
        h(transfer.created_at),
        transfer.id
      ]
    end
  end

  def transfers
    @transfers ||= fetch_transfers
  end

  def fetch_transfers
    transfers=Transfer.order("#{sort_column} #{sort_direction}")
    transfers = transfers.page(page).per_page(per_page)
    if params[:sSearch].present?
      transfers = transfers.where("transfers.id like :search or transfers.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    transfers
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[transfers.id transfers.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
