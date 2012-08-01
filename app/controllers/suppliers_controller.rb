class SuppliersController < ApplicationController
  before_filter :authenticate_user!
  layout "table", :only => [:index]

  def index
    respond_to do |format|
      format.html
      format.json { render json: SuppliersDatatable.new(view_context) }
    end
  end

  def new
    @supplier = Supplier.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @supplier }
    end
  end


  def show
    @supplier = Supplier.find(params[:id])
  end
  def archive
    id=params[:id].to_i * 10
    @suppliers=Supplier.limit(10).offset(id).order("created_at DESC")
    @count=Supplier.count
  end

  def create
    supplier = Supplier.new(params[:supplier])
    if supplier.save

    else
      #todo handle error
      render :json => { :result => 'error'}, :content_type => 'text/html'
    end
  end
  
  def update
    @supplier = Supplier.find(params[:id])
    if @supplier.update_attributes(params[:supplier])
      flash[:notice] = "Successfully updated picture."
      redirect_to root_path
    end
  end

  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy
    redirect_to suppliers_url

  end

  def edit
    @supplier = Supplier.find(params[:id])
  end

end
