require "administrate/base_dashboard"

class MenuDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    truck: Field::BelongsTo,
    id: Field::Number,
    title: Field::String,
    description: Field::Text,
    food_image: Field::Carrierwave,
    price: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :title,
    :description,
    :price,
    :truck,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :title,
    :description,
    :food_image,
    :price,
    :created_at,
    :updated_at,
    :truck,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :title,
    :description,
    :food_image,
    :price,
    :truck,
  ].freeze

  # Overwrite this method to customize how menus are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(menu)
  #   "Menu ##{menu.id}"
  # end
end
