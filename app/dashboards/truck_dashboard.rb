require "administrate/base_dashboard"

class TruckDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    menus: Field::HasMany,
    user: Field::BelongsTo,
    id: Field::Number,
    truck_name: Field::String,
    description: Field::Text,
    main_image: Field::Carrierwave,
    thumb_image: Field::Carrierwave,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    calendar_id: Field::String,
    time_zone: Field::Select.with_options(collection: ["America/Chicago", "America/Denver", "America/Los_Angeles", "America/New_York"]),
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :truck_name,
    :menus,
    :user,
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :truck_name,
    :description,
    :main_image,
    :thumb_image,
    :created_at,
    :updated_at,
    :calendar_id,
    :time_zone,
    :user,
    :menus,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :truck_name,
    :description,
    :main_image,
    :thumb_image,
    :time_zone,
    :menus,
    :user,
  ].freeze

  # Overwrite this method to customize how trucks are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(truck)
  #   "Truck ##{truck.id}"
  # end
end
