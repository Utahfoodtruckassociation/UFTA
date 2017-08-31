class PagesController < ApplicationController
  def home
  	@trucks = Truck.order('created_at ASC')
  end

  def about
  end

  def contact
  end
end
