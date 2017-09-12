class PagesController < ApplicationController
  def home
  	@trucks = Truck.order('created_at ASC')
  	@cal = GoogleCalendarAuth.new

  	count = 0
    @glocation = []
    
  	@cal.events.each do |event|
  		if (Geocoder.coordinates(event.location)) != nil && (event.summary) != nil && event.location.match("UT")
      # && (event.start.date_time).to_date == Date.today
        @glocation << Geocoder.coordinates(event.location)
        @glocation[count] << event.summary
        @glocation[count] << event.start.date_time
        @glocation[count] << event.end.date_time
        count += 1
      end
  	end

  	@hash = Gmaps4rails.build_markers(@glocation) do |loc, marker|
      loc.to_a
      marker.lat loc[0]
      marker.lng loc[1]
      marker.infowindow "<img src='http://pocoinspired.com/t6/wp-content/uploads/2015/09/lunch-truck-it-favicon.jpg', width='50px' /> <br> <p>#{loc[2]}</p>"
    end
  end

  def about
  end

  def contact
  end
end
