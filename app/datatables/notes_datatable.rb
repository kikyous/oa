class NotesDatatable

  delegate :params, :h, :link_to, to: :@view

  def initialize(view,current_user)
    @view = view
    @current_user=current_user
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: notes.count,
      iTotalDisplayRecords: notes.total_entries,
      aaData: data
    }
  end

private

  def data
    notes.map do |note|
      [
        link_to(note.id, note),
        h(note.title),
        h(note.user.username),
        h(note.created_at),
        note.id
      ]
    end
  end

  def notes
    @notes ||= fetch_notes
  end

  def fetch_notes
    notes = @current_user.notes.order("#{sort_column} #{sort_direction}")
    notes = notes.page(page).per_page(per_page)
    if params[:sSearch].present?
      notes = notes.where("notes.name like :search or notes.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    notes
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[notes.id notes.name notes.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
