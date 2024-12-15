require 'date'

class Vehicle
  attr_reader :vin,
              :year,
              :make,
              :model,
              :engine
              
  attr_accessor :plate_type, :registration_date

  def initialize(vehicle_details)
    if vehicle_details.keys.include?(:vin_1_10)
      @vin = vehicle_details[:vin_1_10]
    else
      @vin = vehicle_details[:vin]
    end
    if vehicle_details.keys.include?(:model_year)
     @year = vehicle_details[:model_year]
    else
      @year = vehicle_details[:year]
    end
    @make = vehicle_details[:make]
    @model = vehicle_details[:model]
    @engine = vehicle_details.fetch(:engine, :ev)
    @registration_date = nil
    @plate_type = nil
  end

  def antique?
    Date.today.year - @year > 25
  end

  def electric_vehicle?
    @engine == :ev
  end

end
