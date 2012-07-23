class HomeController < ApplicationController
  before_filter :authenticate_user!
  layout false
  def main
  end

  def down
  end

  def center
  end

  def left
  end

  def tree
  end

  def floatBox
  end
  
end
