class PagesController < ApplicationController
  def home
  	@trucks = Truck.order('created_at ASC')

  	@cal = GoogleCalendarAuth.new

    @glocation = []
  	count = 0
    
  	@cal.events.each do |event|
  		if (Geocoder.coordinates(event.location)) != nil && (event.summary) != nil && event.location.match("UT") && (event.start.date_time).to_date.month == Date.today.month
        @glocation << Geocoder.coordinates(event.location)
        @glocation[count] << event.summary
        @glocation[count] << event.start.date_time
        @glocation[count] << event.end.date_time
        @glocation[count] << event.location
        @glocation[count] << event.html_link
        @glocation[count] << event.creator.email
        image = Truck.select("trucks.thumb_image, trucks.truck_name, users.id").joins(:user).where("users.email = '#{event.creator.email}'")
        image != [] ? @glocation[count] << image.first.thumb_image : @glocation[count] << "http://pocoinspired.com/t6/wp-content/uploads/2015/09/lunch-truck-it-favicon.jpg"
        @glocation[count] << image.first.truck_name if image != []
        @glocation[count] << image.first.id if image != []
        count += 1
      end
  	end

  	@hash = Gmaps4rails.build_markers(@glocation) do |loc, marker|
      loc.to_a
      marker.lat loc[0]
      marker.lng loc[1]
      marker.infowindow "<img src='#{loc[8]}', width='150px' /> <br><br> <a href='/trucks/#{loc[10]}'><h6>#{loc[9]}</h6></a> <a href='#{loc[6]}' target='_blank'>#{loc[2]}</a> <p>#{loc[3].strftime("%I:%M%p")} - #{loc[4].strftime("%I:%M%p")}</p> <a href='https://maps.google.com/maps?q=#{loc[5]}&hl=en' target='_blank'>#{loc[5]}</a>"
    end
    # http://pocoinspired.com/t6/wp-content/uploads/2015/09/lunch-truck-it-favicon.jpg
    if @hash.empty?
      @hash.push({
        lat: request.location.latitude,
        lng: request.location.longitude
      })
    end
  end

  def about
  end

  def contact
  end
end
