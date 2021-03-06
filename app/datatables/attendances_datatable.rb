#!/bin/env ruby
# encoding: utf-8

class AttendancesDatatable
  delegate :params, :h, :link_to,:user_session, to: :@view

  def initialize(view,personal=nil)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: attendances.length,
      iTotalDisplayRecords: attendances.total_entries,
      aaData: data
    }
  end

private

  def data
    attendances.map do |attendance|
      [
        link_to(getStatus(attendance), attendance),
        attendance.for_month.strftime('%Y-%m'),
        attendance.created_at,
        attendance.id
      ]
    end
  end

  def getStatus(attendance)
    if attendance.attach_ids.blank?
      return "未考勤"
    else
      return "已考勤"
    end
  end


  def attendances
    @attendances ||= fetch_attendances
  end

  def fetch_attendances
    attendances = Attendance.order("#{sort_column} #{sort_direction}")
    attendances = attendances.page(page).per_page(per_page)
    if params[:sSearch].present?
      attendances = attendances.where("users.username like :search or attendances.created_at like :search", search: "%#{params[:sSearch]}%")
    end
    attendances
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[attendances.id attendances.for_month attendances.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
