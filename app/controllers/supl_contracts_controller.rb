class SuplContractsController < ApplicationController
  before_filter :authenticate_user!
  layout "table", :only => [:index]
  def index
  end

  def new
    @supl_contract = SuplContract.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @supl_contract }
    end
  end


  def show
    @supl_contract = SuplContract.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @supl_contract }
    end
  end


  def edit
    @supl_contract = SuplContract.find(params[:id])
  end
  
  def archive
    id=params[:id].to_i * 10
    @supl_contracts=SuplContract.limit(10).offset(id).order("created_at DESC")
    # @supl_contracts_dict=supl_contracts.group_by(&:supl_contract_id)
  end

  def create
    begin
      params[:supl_contract][:attach_ids]=params[:supl_contract][:attach_ids].join(",")
    rescue => err
      p err
    end
      
    supl_contract = SuplContract.new(params[:supl_contract])
    if supl_contract.save
      redirect_to supl_contracts_path
    else
      #todo handle error
      render :json => { :result => 'error'}, :content_type => 'text/html'
    end
  end
  
  def update
    begin
      params[:supl_contract][:attach_ids]=params[:supl_contract][:attach_ids].join(",")
    rescue => err
      p err
    end

    @supl_contract = SuplContract.find(params[:id])
    if @supl_contract.update_attributes(params[:supl_contract])
      flash[:notice] = "Successfully updated picture."
      redirect_to supl_contracts_path
    end
  end

  def destroy
    @supl_contract = SuplContract.find(params[:id])
    @supl_contract.destroy
    redirect_to supl_contracts_url

  end

end
