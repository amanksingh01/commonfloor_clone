module PropertiesHelper

  # Returns the property title for the given property.
  def property_title(property)
    (property.bed_rooms == 'na' ? (property.area.to_s + " sq. ft.") :
                                   property.bed_rooms.upcase) + " " +
    property.property_type.capitalize + " for " +
    property.property_status.capitalize + " in " +
    property.locality.titleize + ", " +
    property.city.titleize
  end
end