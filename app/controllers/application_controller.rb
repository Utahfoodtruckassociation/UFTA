class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include DeviseWhitelist
  include CurrentUserConcern
  include DefaultPageContent

  around_action :user_time_zone, if: :current_user

	def user_time_zone(&block)
	  time_zone = current_user.try(:time_zone) || 'Mountain Time (US & Canada)'
    Time.use_zone(time_zone, &block)
	end
end
