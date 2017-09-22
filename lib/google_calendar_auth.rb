# https://stackoverflow.com/questions/40722687/how-to-set-up-google-calendar-api-using-ruby-client-for-server-to-server-applica
require 'googleauth'
require 'google/apis/calendar_v3'

class GoogleCalendarAuth

  def initialize
    authorize
  end

  def service
    @service
  end

  def events(reload=false)
    # NOTE: This is just for demonstration purposes and not complete.
    # If you have more than 2500 results, you'll need to get more than    
    # one set of results.
    @events = nil if reload

    @events ||= service.list_events(calendar_id,
                                    max_results: 20,
                                    single_events: true,
                                    order_by: 'startTime',
                                    time_min: Time.now.iso8601).items

  end

private

  def calendar_id
    @calendar_id ||= ENV['GOOGLE_CALENDAR_ID'] # The calendar ID you copied in step 20 above (or some reference to it).  
  end

  def authorize
    calendar = Google::Apis::CalendarV3::CalendarService.new
    # calendar.client_options.application_name = 'App Name' # This is optional
    # calendar.client_options.application_version = 'App Version' # This is optional

    # An alternative to the following line is to set the ENV variable directly 
    # in the environment or use a gem that turns a YAML file into ENV variables
    ENV['GOOGLE_APPLICATION_CREDENTIALS'] = "lib/google_api.json"
    scopes = [Google::Apis::CalendarV3::AUTH_CALENDAR]
    calendar.authorization = Google::Auth.get_application_default(scopes)

    @service = calendar
  end

end