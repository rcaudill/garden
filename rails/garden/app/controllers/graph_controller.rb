class GraphController < ApplicationController
  # GET /readings
  # GET /readings.json
  def index
    @readings = Reading.all
    @current = @readings.last
   
    @json = "[" + @readings.map { |i| "[" + "%d000"%i.time_stamp.to_i + "," + i.reading.to_s + "]" }.join(",") + "]"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @readings }
      format.json { render json: @json }
    end
  end
end
