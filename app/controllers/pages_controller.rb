class PagesController < ApplicationController
  def home
  	@trucks = Truck.order("RANDOM()") # .order('created_at ASC')

  	@cal = GoogleCalendarAuth.new

    @calendars = @cal.service.list_calendar_lists

    @glocation = []
  	count = 0

    @color = ["23B1365F", "235C1158", "23711616", "23691426", "23BE6D00", "23B1440E", "23853104", "238C500B", "23754916", "2388880E", "23AB8B00", "23856508", "2328754E", "231B887A", "2328754E", "230D7813", "23528800", "23125A12", "232F6309", "232F6213", "230F4B38", "235F6B02", "234A716C", "236E6E41", "2329527A", "232952A3", "234E5D6C", "235A6986", "23182C57", "23060D5E", "23113F47", "237A367A", "235229A3", "23865A5A", "23705770", "2323164E", "235B123B", "2342104A", "23875509", "238D6F47", "236B3304", "23333333"]
    
    @cal.service.list_calendar_lists.items.each do |calendar|

      @events = @cal.service.list_events(calendar.id,
                                    max_results: 20,
                                    single_events: true,
                                    order_by: 'startTime',
                                    time_min: Time.now.iso8601)

    	@events.items.each do |event|
    		if (Geocoder.coordinates(event.location)) != nil && (event.summary) != nil && event.location.downcase.match("ut") && (event.start.date_time).to_date == Date.today
          @glocation << Geocoder.coordinates(event.location)
          @glocation[count] << event.summary
          @glocation[count] << event.start.date_time
          @glocation[count] << event.end.date_time
          @glocation[count] << event.location
          @glocation[count] << event.html_link
          @glocation[count] << event.creator.email
          image = Truck.select("trucks.thumb_image, trucks.truck_name, users.id").joins(:user).where("users.email = '#{event.creator.email}'")
          image = Truck.select(:thumb_image, :truck_name, :id).where("trucks.calendar_id = '#{event.organizer.email}'") if image == []
          image[0][:thumb_image] != nil ? @glocation[count] << image.first.thumb_image : @glocation[count] << view_context.image_path("lunch-truck-it-favicon.jpg")
          @glocation[count] << image.first.truck_name if image != []
          @glocation[count] << image.first.id if image != []
          count += 1
        end
    	end
    end

  	@hash = Gmaps4rails.build_markers(@glocation) do |loc, marker|
      loc.to_a
      marker.lat loc[0]
      marker.lng loc[1]
      marker.infowindow "
      <a href='/trucks/#{loc[10]}'>
        <img src='#{loc[8]}', width='150px' />
        <h6>#{loc[9]}</h6>
      </a>
      <a href='#{loc[6]}' target='_blank'>#{loc[2]}</a>
      <p>#{loc[3].strftime("%I:%M%p")} - #{loc[4].strftime("%I:%M%p")}</p>
      <a href='https://maps.google.com/maps?q=#{loc[5]}&hl=en' target='_blank'>#{loc[5]}</a>"
    end
    
    # http://pocoinspired.com/t6/wp-content/uploads/2015/09/lunch-truck-it-favicon.jpg
    # if @hash.empty?
    #   @hash.push({
    #     lat: request.location.latitude,
    #     lng: request.location.longitude
    #   })
    # end
  end

  def about
  end

  def contact
  end

  def document
  end
end
