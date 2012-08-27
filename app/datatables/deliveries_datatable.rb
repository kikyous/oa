class DeliveriesDatatable

  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: deliveries.count,
      iTotalDisplayRecords: deliveries.total_entries,
      aaData: data
    }
  end

private

  def data
    deliveries.map do |delivery|
      [
        link_to(delivery.id, delivery),
        delivery.to,
        delivery.goods,
        h(delivery.created_at),
        delivery.id
      ]
    end
  end

  def deliveries
    @deliveries ||= fetch_deliveries
  end

  def fetch_deliveries
    deliveries=Delivery.order("#{sort_column} #{sort_direction}")
    deliveries = deliveries.page(page).per_page(per_page)
    if params[:sSearch].present?
      deliveries = deliveries.where("deliveries.id like :search or deliveries.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    deliveries
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[deliveries.id deliveries.to deliveries.goods deliveries.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
