class SalesContractsDatatable
  delegate :params, :h, :link_to, :client_path,to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: SalesContract.count,
      iTotalDisplayRecords: sales_contracts.total_entries,
      aaData: data
    }
  end

private

  def data
    sales_contracts.map do |contract|
      [
        link_to(contract.id, contract),
        contract.name,
        contract.money,
        link_to(contract.client.name, client_path(contract.client)),
        h(contract.created_at),
        contract.id
      ]
    end
  end

  def sales_contracts
    @sales_contracts ||= fetch_sales_contracts
  end

  def fetch_sales_contracts
    sales_contracts = SalesContract.order("#{sort_column} #{sort_direction}")
    sales_contracts = sales_contracts.page(page).per_page(per_page)
    if params[:sSearch].present?
      sales_contracts = sales_contracts.where("sales_contracts.name like :search or sales_contracts.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    sales_contracts
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[sales_contracts.id sales_contracts.name sales_contracts.money 
    sales_contracts.client sales_contracts.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
