class SuplContractsDatatable
  delegate :params, :h, :link_to, :supplier_path ,to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: SuplContract.count,
      iTotalDisplayRecords: supl_contracts.total_entries,
      aaData: data
    }
  end

private

  def data
    supl_contracts.map do |contract|
      [
        link_to(contract.id, contract),
        contract.name,
        contract.money,
        link_to(contract.supplier.name, supplier_path(contract.supplier)),
        h(contract.created_at),
        contract.id
      ]
    end
  end

  def supl_contracts
    @supl_contracts ||= fetch_supl_contracts
  end

  def fetch_supl_contracts
    supl_contracts = SuplContract.includes("supplier").order("#{sort_column} #{sort_direction}")
    supl_contracts = supl_contracts.page(page).per_page(per_page)
    if params[:sSearch].present?
      supl_contracts = supl_contracts.where("suppliers.name like :search or supl_contracts.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    supl_contracts
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[supl_contracts.id supl_contracts.name supl_contracts.money
      suppliers.name suppliers.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
