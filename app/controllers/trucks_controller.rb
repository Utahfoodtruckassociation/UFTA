class TrucksController < ApplicationController
  before_action :set_truck, only: [:show, :edit, :update, :destroy, :new_event, :create_event, :delete_event]
  layout "truck"

  # GET /trucks
  # GET /trucks.json
  def index
    # @trucks = Truck.order('created_at ASC')

    if params[:search]
      @trucks = Truck.search(params[:search]).order('created_at ASC')
      # @trucks = Truck.search(params[:search]).order("created_at DESC")
    elsif params[:dropdown]
      @trucks = Truck.dropdown(params[:dropdown]).order('created_at ASC')
    else
      @trucks = Truck.order('created_at ASC')
    end
  end

  # GET /trucks/1
  # GET /trucks/1.json
  def show
    @cal = GoogleCalendarAuth.new

    @glocation = []
    count = 0

    @cal.service.list_calendar_lists.items.each do |calendar|

      @events = @cal.service.list_events(calendar.id,
                                    max_results: 20,
                                    single_events: true,
                                    order_by: 'startTime',
                                    time_min: Time.now.iso8601)

      @events.items.each do |event|
        if (Geocoder.coordinates(event.location)) != nil && (event.summary) != nil && event.location.downcase.match("ut") && (event.start.date_time).to_date >= (Date.today - 1)
          @glocation << Geocoder.coordinates(event.location)
          @glocation[count] << event.summary
          @glocation[count] << event.start.date_time
          @glocation[count] << event.end.date_time
          @glocation[count] << event.location
          email = Truck.select("trucks.truck_name, users.email, users.id").joins(:user).where("users.email = '#{event.creator.email}'")
          email = Truck.select(:truck_name, :id).where("trucks.calendar_id = '#{event.organizer.email}'") if email == []
          # binding.pry
          @glocation[count] << email.first.truck_name if email != []
          @glocation[count] << event.id
          count += 1
        end
      end
    end
  end

  def new_event
  end

  def create_event
    info = params.permit(:summary, :description, :location, :start_time, :end_time)

    @cal = GoogleCalendarAuth.new

    result = @cal.new_event(@truck, info)

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

    @cal = GoogleCalendarAuth.new

    @cal.delete_event(@truck, event_id)

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
