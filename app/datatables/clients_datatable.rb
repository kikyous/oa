class ClientsDatatable
  delegate :params, :h, :link_to, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: clients.count,
      iTotalDisplayRecords: clients.total_entries,
      aaData: data
    }
  end

private

  def data
    clients.map do |client|
      [
        link_to(client.id, client),
        h(client.name),
        h(client.created_at),
        client.id
      ]
    end
  end

  def clients
    @clients ||= fetch_Clients
  end

  def fetch_Clients
    clients = Client.order("#{sort_column} #{sort_direction}")
    clients = clients.page(page).per_page(per_page)
    if params[:sSearch].present?
      clients = clients.where("clients.name like :search or clients.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    clients
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[clients.id clients.name clients.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
