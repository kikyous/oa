class AttachesController < ApplicationController
  before_filter :authenticate_user!

  def new
  end

  def create
    attach = Attach.new(params[:attach])
    if attach.save
      render :json => attach
    else
      #todo handle error
      render :json => { :result => 'error'}, :content_type => 'text/html'
    end
  end
  
  def update
    @upload = Upload.find(params[:id])
    if @upload.update_attributes(params[:upload])
      flash[:notice] = "Successfully updated picture."
      redirect_to root_path
    end
  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy
    redirect_to uploads_url

  end


end
