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

  # -------------------------
  # For future development for calendar feature
  # -------------------------

  # def list_acl
  #   result = authorize.list_acls('15frgq5mk4sjtkmiv6mfnrna0g@group.calendar.google.com')
  #   result.items.each do |e|
  #     print e.id + ": " + e.role + "\n"
  #   end
  # end

  # def update_acl
  #   rule = authorize.get_acl('ufoodtruck@ufta-177701.iam.gserviceaccount.com', 'user:15frgq5mk4sjtkmiv6mfnrna0g@group.calendar.google.com')
  #   rule.scope.type = 'default'
  #   result = authorize.update_acl('ufoodtruck@ufta-177701.iam.gserviceaccount.com', rule.id, rule)
  #   print result.etag
  # end

  def new_calendar(truck)
    # calendar = Google::Apis::CalendarV3::Calendar.new(
    #   summary: 'calendarSummary',
    #   time_zone: 'America/Los_Angeles'
    # )
    # result = client.insert_calendar(calendar)
    # print result.id

    calendar = Google::Apis::CalendarV3::Calendar.new(
      summary: truck.truck_name,
      time_zone: truck.time_zone
    )
    result = authorize.insert_calendar(calendar)
    truck.calendar_id = result.id #save this id in to the database to connect a user to a calendar
  end

  def update_calendar(truck)
    # calendar = authorize.get_calendar('primary')
    calendar = authorize.get_calendar(truck.calendar_id)
    calendar.summary = truck.truck_name
    calendar.time_zone = truck.time_zone
    result = authorize.update_calendar(calendar.id, calendar)
    # truck.calendar_id = result.id
  end

  def destroy_calendar(truck)
    authorize.delete_calendar(truck.calendar_id)
  end

  def new_event(truck, info)
    # binding.pry
    event = Google::Apis::CalendarV3::Event.new({
      summary: info[:summary],
      location: info[:location],
      description: info[:description],
      start: {
        date_time: (info[:start_time].to_datetime),
        time_zone: truck.time_zone,
      },
      end: {
        date_time: (info[:end_time].to_datetime),
        time_zone: truck.time_zone,
      },
      # recurrence: [
      #   'RRULE:FREQ=DAILY;COUNT=2'
      # ],
      # attendees: [
      #   {email: 'lpage@example.com'},
      #   {email: 'sbrin@example.com'},
      # ],
      # reminders: {
      #   use_default: false,
      #   overrides: [
      #     {method' => 'email', 'minutes: 24 * 60},
      #     {method' => 'popup', 'minutes: 10},
      #   ],
      # },
    })

    # result = authorize.insert_event('primary', event)
    result = authorize.insert_event(truck.calendar_id, event)
    # puts "Event created: #{result.html_link}"
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