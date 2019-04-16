class StaticPagesController < ApplicationController
  def home
    visitor = Visitor.find_or_initialize_by(remote_ip: request.remote_ip)
    if visitor.new_record?
      visitor.save
      if Rails.cache.fetch('visitors_count')
        Rails.cache.write('visitors_count',
                          Rails.cache.read('visitors_count') + 1)
      end
    end
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
