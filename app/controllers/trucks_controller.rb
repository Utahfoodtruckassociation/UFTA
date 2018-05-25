class TrucksController < ApplicationController
  before_action :set_truck, only: [:show, :edit, :update, :destroy, :new_event, :create_event, :delete_event, :follow_truck_guest, :follow_truck]
  layout "truck"
  access all: [:show, :index], user: {except: [:destroy, :new, :create, :update, :edit, :follow_truck, :new_event, :create_event, :delete_event]}, truck: :all, admin: :all

  # GET /trucks
  # GET /trucks.json
  def index
    # @trucks = Truck.order('created_at ASC')

    if params[:search]
      @trucks = Truck.search(params[:search]).order('created_at ASC').uniq
      # @trucks = Truck.search(params[:search]).order("created_at DESC")
    elsif params[:dropdown]
      @trucks = Truck.dropdown(params[:dropdown]).order('created_at ASC')
    else
      @trucks = Truck.order("RANDOM()") # .order('created_at ASC')
    end
  end

  # GET /trucks/1
  # GET /trucks/1.json
  def show
    @seo_keywords = @truck.description
    
    @cal = GoogleCalendarAuth.new

    @glocation = []
    count = 0

    @cal.service.list_calendar_lists.items.each do |calendar|

      @events = @cal.service.list_events(calendar.id,
                                    max_results: 10,
                                    single_events: true,
                                    order_by: 'startTime',
                                    time_min: Time.now.iso8601)

      @events.items.each do |event|
        if (Geocoder.coordinates(event.location)) != nil && (event.summary) != nil  && (event.start.date_time).to_date >= (Date.today - 1)
          # && event.location.downcase.match("ut")
          @glocation << Geocoder.coordinates(event.location)
          @glocation[count] << event.summary
          @glocation[count] << event.start.date_time
          @glocation[count] << event.end.date_time
          @glocation[count] << event.location
          email = Truck.select("trucks.truck_name, users.email, users.id").joins(:user).where("users.email = '#{event.creator.email}'")
          email = Truck.select(:truck_name, :id).where("trucks.calendar_id = '#{event.organizer.email}'") if email == []
          @glocation[count] << email.first.truck_name if email != []
          @glocation[count] << event.id
          @glocation[count] << event.html_link
          @glocation[count] << event.recurring_event_id
          count += 1
        end
      end
    end

    @map = []

    @glocation.each do |event|
      if event[6] == @truck.truck_name
        @map << event
      end
    end

    @hash = Gmaps4rails.build_markers(@map) do |loc, marker|
      marker.lat loc[0]
      marker.lng loc[1]
      marker.infowindow "
      <center>
      <h6>#{loc[6]}</h6>
      <a href='#{loc[8]}' target='_blank'>#{loc[2]}</a>
      <p>#{loc[3].to_date.strftime("%b. %d")}, #{loc[3].strftime("%I:%M%p")} - #{loc[4].to_date.strftime("%b. %d")}, #{loc[4].strftime("%I:%M%p")} #{Time.parse((loc[3].to_datetime).to_s).strftime("%Z")}</p>
      <a href='https://maps.google.com/maps?q=#{loc[5]}&hl=en' target='_blank'>#{loc[5]}</a>
      </center>"
    end
  end

  def follow_truck_guest
    info = params.permit(:email)

    # rails g migration add_emails_to_trucks emails:text
    # , array:true, default: []
    # if info[:email] != ""
    #   @truck.emails.push(info[:email])
    #   @truck.save!
    # end

    @cal = GoogleCalendarAuth.new

    result = @cal.insert_acl_share_guest(@truck, info) if info[:email] != ""

    respond_to do |format|
      if result != nil
        format.html { redirect_to @truck, notice: 'You are now following this truck.' }
      else
        format.html { redirect_to @truck, notice: 'You need to enter a valid Google email.' }
      end
    end
  end

  def follow_truck
    info = params.permit(:email)

    # rails g migration add_emails_to_trucks emails:text
    # , array:true, default: []
    # if info[:email] != ""
    #   @truck.emails.push(info[:email])
    #   @truck.save!
    # end

    @cal = GoogleCalendarAuth.new

    result = @cal.insert_acl_share_truck(@truck, info) if info[:email] != ""

    respond_to do |format|
      if result != nil
        format.html { redirect_to @truck, notice: 'You are now following this truck.' }
      else
        format.html { redirect_to @truck, notice: 'You need to enter a valid Google email.' }
      end
    end
  end

  def new_event
  end

  def create_event
    info = params.permit(:summary, :description, :location, :start_time, :end_time, :Repeat, :freq, :interval, week: [days: []])

    @cal = GoogleCalendarAuth.new

    if info[:Repeat]
      result = @cal.new_event_recurrence(@truck, info)
    else
      result = @cal.new_event(@truck, info)
    end

    # binding.pry

    respond_to do |format|
      if result != nil
        format.html { redirect_to @truck, notice: 'Event was successfully created.' }
      else
        format.html { render :new_event }
      end
    end
  end

  def delete_event
    event_id = params[:event_id]
    recurring_event_id = params[:recurring_event_id]

    @cal = GoogleCalendarAuth.new

    @cal.delete_event(@truck, event_id, recurring_event_id)

    respond_to do |format|
      format.html { redirect_to @truck, notice: 'Event was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  # GET /trucks/new
  def new
    @truck = Truck.new
  end

  # GET /trucks/1/edit
  def edit
  end

  # POST /trucks
  # POST /trucks.json
  def create
    @truck = Truck.new(truck_params)
    @truck.user_id = current_user.id

    @cal = GoogleCalendarAuth.new

    @cal.new_calendar(@truck) if (@truck.truck_name != "" && @truck.time_zone != "" && @truck.food_type != "" && @truck.description != "")

    respond_to do |format|
      if @truck.save
        format.html { redirect_to @truck, notice: 'Truck was successfully created.' }
        format.json { render :show, status: :created, location: @truck }
      else
        format.html { render :new }
        format.json { render json: @truck.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trucks/1
  # PATCH/PUT /trucks/1.json
  def update
    @cal = GoogleCalendarAuth.new

    @cal.update_calendar(@truck)

    respond_to do |format|
      if @truck.update(truck_params)
        format.html { redirect_to @truck, notice: 'Truck was successfully updated.' }
        format.json { render :show, status: :ok, location: @truck }
      else
        format.html { render :edit }
        format.json { render json: @truck.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trucks/1
  # DELETE /trucks/1.json
  def destroy
    @truck.destroy

    @cal = GoogleCalendarAuth.new

    @cal.destroy_calendar(@truck)

    respond_to do |format|
      format.html { redirect_to trucks_url, notice: 'Truck was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_truck
      @truck = Truck.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def truck_params
      params.require(:truck).permit(:truck_name,
                                    :description,
                                    :food_type,
                                    :main_image,
                                    :thumb_image,
                                    :user_id,
                                    :calendar_id,
                                    :time_zone,
                                    menus_attributes: [:id, :title, :description, :food_image, :price, :_destroy])
    end
end
