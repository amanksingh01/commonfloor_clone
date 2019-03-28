require 'test_helper'

class PropertiesShowTest < ActionDispatch::IntegrationTest
  include ActionView::Helpers::DateHelper
  
  def setup
    @property      = properties(:salt_lake)
    @seller        = @property.user
    @admin         = users(:aman)
    @non_admin     = users(:oliver)
    @sold_property = properties(:sold)
  end

  test "property display with comments and correct links for it's seller" do
    get property_path(@property)
    assert_not_nil session[:forwarding_url]
    log_in_as(@seller)
    assert_redirected_to property_path(@property)
    follow_redirect!
    assert_template 'properties/show'

    assert_match @property.owner_name.titleize,        response.body
    assert_match @property.property_type.capitalize,   response.body
    assert_match @property.property_status.capitalize, response.body
    assert_match @property.bed_rooms.upcase,           response.body
    assert_match @property.area.to_s,                  response.body
    assert_match @property.price.to_s,                 response.body
    assert_match @property.street_address.titleize,    response.body
    assert_match @property.locality.titleize,          response.body
    assert_match @property.city.titleize,              response.body
    assert_match @property.state.titleize,             response.body
    assert_match @property.pincode,                    response.body
    assert_match @property.country.titleize,           response.body

    assert_select 'a[href=?]', user_path(@seller), text: @seller.name
    assert_select 'a[href=?]', interested_users_property_path(@property),
                  text: "Interested users (#{@property.interested_users.count})"
    assert_select 'a[href=?]', mark_as_sold_property_path(@property),
                  text: "Mark as sold"
    assert_select 'a[href=?]', edit_property_path(@property),
                  text: 'Modify property details'
    assert_select 'a[href=?]', property_path(@property), text: 'Delete property'

    # Property comments
    assert_template 'shared/_new_comment'
    assert_template 'shared/_comment_form'
    assert_template 'comments/_comment'
    assert_match @property.comments.count.to_s, response.body
    assigns(:comments).each do |comment|
      assert_select 'h5>img.gravatar'
      assert_match comment.user.name, response.body
      assert_match comment.comment,   response.body
      assert_match time_ago_in_words(comment.created_at), response.body
    end
    assert_select 'nav.pagination'

    # Correct links for sold property
    get property_path(@sold_property)
    assert_select 'h2.sold-tag', text: 'Sold'
    assert_select 'a[href=?]', interested_users_property_path(@property),
                  count: 0
    assert_select 'a[href=?]', mark_as_sold_property_path(@property), count: 0
    assert_select 'a[href=?]', edit_property_path(@property), count: 0
    assert_select 'a[href=?]', property_path(@property), count: 0
  end

  test "property display with correct links for admins" do
    log_in_as(@admin)
    get property_path(@property)
    assert_template 'shared/_wishlist_form'
    assert_template 'shared/_remove_from_wishlist'

    assert_select 'a[href=?]', user_path(@seller), text: @seller.name
    assert_select 'form[action=?]',
                  wishlist_path(@admin.wishlists.find_by(property: @property))
    assert_select 'a[href=?]', interested_users_property_path(@property),
                  count: 0
    assert_select 'a[href=?]', mark_as_sold_property_path(@property), count: 0
    assert_select 'a[href=?]', edit_property_path(@property),
                  text: 'Modify property details'
    assert_select 'a[href=?]', property_path(@property), text: 'Delete property'
    
    assigns(:comments).each do |comment|
      assert_select 'a[href=?]', comment_path(comment), text: 'Delete'
    end

    # Correct links for sold property
    get property_path(@sold_property)
    assert_select 'form[action=?]',
                  wishlist_path(@admin.wishlists.find_by(property: @sold_property))
    assert_select 'a[href=?]', edit_property_path(@property), count: 0
    assert_select 'a[href=?]', property_path(@property), count: 0
  end

  test "property display with correct links for other users" do
    log_in_as(@non_admin)
    get property_path(@property)
    assert_template 'shared/_wishlist_form'
    assert_template 'shared/_add_to_wishlist'

    assert_select 'a[href=?]', user_path(@seller), text: @seller.name
    assert_select 'form[action=?]', wishlists_path
    assert_select 'a[href=?]', interested_users_property_path(@property),
                  count: 0
    assert_select 'a[href=?]', mark_as_sold_property_path(@property), count: 0
    assert_select 'a[href=?]', edit_property_path(@property), count: 0
    assert_select 'a[href=?]', property_path(@property), count: 0

    # Correct links for sold property
    get property_path(@sold_property)
    assert_select 'form[action=?]', wishlists_path, count: 0
    assert_select 'a[href=?]', edit_property_path(@property), count: 0
    assert_select 'a[href=?]', property_path(@property), count: 0
  end
end