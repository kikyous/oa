class MessagesDatatable

  delegate :params, :h, :link_to ,:msg_status,:find_user,:message_path,:conversation, to: :@view

  def initialize(view,current_user)
    @view = view
    @current_user=current_user
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: messages.count,
      iTotalDisplayRecords: messages.total_entries,
      aaData: data
    }
  end

private

  def data
    messages.map do |message|
      [
        link_to(msg_status(message.conversation.first), message_path(message)),
        h(find_user(message.sent_messageable_id).username),
        h(message.topic),
        message.created_at,
        message.id
      ]
    end
  end

  def messages
    @messages ||= fetch_messages
  end


  def fetch_messages
    messages = @current_user.messages.where(:ancestry => nil).order("#{sort_column} #{sort_direction}")
    messages = messages.page(page).per_page(per_page)
    if params[:sSearch].present?
      messages = messages.where("messages.name like :search or messages.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    messages
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[messages.id messages.topic messages.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
