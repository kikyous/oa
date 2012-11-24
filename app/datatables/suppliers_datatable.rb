class SuppliersDatatable
  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Supplier.count,
      iTotalDisplayRecords: suppliers.total_entries,
      aaData: data
    }
  end

private

  def data
    suppliers.map do |supplier|
      [
        link_to(supplier.id, supplier),
        h(supplier.name),
        h(supplier.created_at),
        supplier.id
      ]
    end
  end

  def suppliers
    @suppliers ||= fetch_suppliers
  end

  def fetch_suppliers
    suppliers = Supplier.order("#{sort_column} #{sort_direction}")
    suppliers = suppliers.page(page).per_page(per_page)
    if params[:sSearch].present?
      suppliers = suppliers.where("suppliers.name like :search or suppliers.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    suppliers
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[suppliers.id suppliers.name suppliers.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
