class InStoresDatatable

  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: in_stores.count,
      iTotalDisplayRecords: in_stores.total_entries,
      aaData: data
    }
  end

private

  def data
    in_stores.map do |in_store|
      [
        link_to(in_store.id, in_store),
        in_store.name,
        h(in_store.created_at),
        in_store.id
      ]
    end
  end

  def in_stores
    @in_stores ||= fetch_in_stores
  end

  def fetch_in_stores
    in_stores=InStore.order("#{sort_column} #{sort_direction}")
    in_stores = in_stores.page(page).per_page(per_page)
    if params[:sSearch].present?
      in_stores = in_stores.where("in_stores.id like :search or in_stores.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    in_stores
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[in_stores.id in_stores.name in_stores.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
