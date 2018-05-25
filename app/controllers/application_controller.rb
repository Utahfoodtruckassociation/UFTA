class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include DeviseWhitelist
  include CurrentUserConcern
  include DefaultPageContent

  around_action :user_time_zone, if: :current_user

	def user_time_zone(&block)
	  Time.use_zone(current_user.time_zone, &block)
	end
end
