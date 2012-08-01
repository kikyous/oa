class AttachesController < ApplicationController
  before_filter :authenticate_user!

  def new
  end

  def create
    attach = Attach.new(params[:attach])
    if attach.save
      render :json => attach
    else
      render :json => { :result => 'error'}, :content_type => 'text/html'
    end
  end

  def destroy
    @attach = Attach.find(params[:id])
    @attach.destroy
  end
end
