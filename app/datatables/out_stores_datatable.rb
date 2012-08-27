class OutStoresDatatable

  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: out_stores.count,
      iTotalDisplayRecords: out_stores.total_entries,
      aaData: data
    }
  end

private

  def data
    out_stores.map do |out_store|
      [
        link_to(out_store.id, out_store),
        out_store.name,
        out_store.person,
        h(out_store.created_at),
        out_store.id
      ]
    end
  end

  def out_stores
    @out_stores ||= fetch_out_stores
  end

  def fetch_out_stores
    out_stores=OutStore.order("#{sort_column} #{sort_direction}")
    out_stores = out_stores.page(page).per_page(per_page)
    if params[:sSearch].present?
      out_stores = out_stores.where("out_stores.id like :search or out_stores.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    out_stores
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[out_stores.id out_stores.name out_stores.person out_stores.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
