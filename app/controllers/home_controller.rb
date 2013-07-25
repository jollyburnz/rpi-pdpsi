class HomeController < ApplicationController
  def index
    @events = Event.all
    @galleries = Gallery.all
  end

end
