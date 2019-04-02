class StaticPagesController < ApplicationController
  def home
    @apartments = Property.where(approved: true)
                          .where(sold: false)
                          .property_type("apartment")
                          .order_by("desc")
                          .take(4)
    @houses     = Property.where(approved: true)
                          .where(sold: false)
                          .property_type("house")
                          .order_by("desc")
                          .take(4)
    @plots      = Property.where(approved: true)
                          .where(sold: false)
                          .property_type("plot")
                          .order_by("desc")
                          .take(4)
    @properties_grid_col = "col-md-6 col-lg-3"
  end

  def help
  end

  def about
  end

  def contact
  end
end
