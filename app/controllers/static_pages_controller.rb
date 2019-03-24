class StaticPagesController < ApplicationController
  def home
    @apartments = Property.property_type("apartment").order_by("desc").take(4)
    @houses     = Property.property_type("house").order_by("desc").take(4)
    @plots      = Property.property_type("plot").order_by("desc").take(4)
    @properties_grid_col = "col-md-6 col-lg-3"
  end

  def help
  end

  def about
  end

  def contact
  end
end
