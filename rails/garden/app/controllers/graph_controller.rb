class GraphController < ApplicationController
  # GET /readings
  # GET /readings.json
  def index
    @readings = Reading.all
    @current = @readings.last
   
    @json="["
    @readings.each do |x|
      s = x.time_stamp.to_i.to_s
      s << "000"
      # s[8]="0"
      # s[9]="0"
      @json += "[#{s},#{x.reading}],"
    end
    @json=@json[0..-2]+"]"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @readings }
      format.json { render json: @json }
    end
  end
end
