
##
## This controller is not used!
##
class ApplicationController < ActionController::Base

  def home
    # flash[:notice] = 'okk'
  end

  def section
    render "sections/#{params[:which]}", layout: 'bootstrap'
  end

  def sections_one
    render 'sections/one', layout: 'bootstrap'
  end

  def sections_carousel
    render 'sections/carousel', layout: 'bootstrap'
  end

  ##
  ## private
  ##
  private

end
