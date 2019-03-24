module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "CommonfloorClone"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # Returns a link tag for mobile numbers.
  def tel_to(number)
    mobile_number = number_to_phone(number, delimiter: " ", country_code: 91,
                                            pattern: /(\d{5})(\d{5})$/)
    link_to mobile_number, "tel:#{mobile_number}"
  end
end