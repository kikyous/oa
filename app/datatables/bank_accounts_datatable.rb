class BankAccountsDatatable

  delegate :params, :h, :link_to ,to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: bank_accounts.count,
      iTotalDisplayRecords: bank_accounts.total_entries,
      aaData: data
    }
  end

private

  def data
    bank_accounts.map do |bank_account|
      [
        link_to(status(bank_account.status), bank_account),
        h(bank_account.money),
        h(bank_account.bank),
        h(bank_account.expire),
        h(bank_account.created_at),
        bank_account.id
      ]
    end
  end

  def bank_accounts
    @bank_accounts ||= fetch_bank_accounts
  end

  def fetch_bank_accounts
    bank_accounts=BankAccount.order("#{sort_column} #{sort_direction}")
    bank_accounts = bank_accounts.page(page).per_page(per_page)
    if params[:sSearch].present?
      bank_accounts = bank_accounts.where("bank_accounts.id like :search or bank_accounts.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    bank_accounts
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[bank_accounts.id bank_accounts.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
