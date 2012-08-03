class AttendancesController < ApplicationController
  before_filter :authenticate_user!
  layout "table", :only => [:index]
  # GET /attendances
  # GET /attendances.json
  def index
    respond_to do |format|
      format.html
      format.js { 
        user_session[:for_month]||=Attendance.order("for_month DESC").first.for_month
        render :js => "filter('#{user_session[:for_month]}',true); " 
      }
      format.json { render json: AttendancesDatatable.new(view_context) }
    end
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
    @attendance = Attendance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @attendance }
    end
  end

  # GET /attendances/new
  # GET /attendances/new.json
  def new
    @attendance = Attendance.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @attendance }
    end
  end

  # GET /attendances/1/edit
  def edit
    @attendance = Attendance.find(params[:id])
  end

  # POST /attendances
  # POST /attendances.json
  def create
    
    User.all.each do |u|
      u.attendances.create(:for_month=>params[:for_month])
    end
    respond_to do |format|
      format.js { 
        render :js => "filter('#{params[:for_month]}',true); " 
      }
    end

  end

  # PUT /attendances/1
  # PUT /attendances/1.json
  def update
    begin
      params[:attendance][:attach_ids]=params[:attendance][:attach_ids].join(",")
    rescue => err
      p err
    end
    rm_unneed_attach
    @attendance = Attendance.find(params[:id])

    respond_to do |format|
      if @attendance.update_attributes(params[:attendance])
        format.html { redirect_to @attendance, notice: 'Attendance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance = Attendance.find(params[:id])
    @attendance.destroy

    respond_to do |format|
      format.html { redirect_to attendances_url }
      format.json { head :no_content }
    end
  end

  private

  def rm_unneed_attach()
    begin
      Attach.find(params[:unneed_attach][:attach_ids]).each do |a|
        a.destroy
      end
    rescue => err
      p err
    end
  end
end
