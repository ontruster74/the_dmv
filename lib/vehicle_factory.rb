class VehicleFactory
  
  def create_vehicles(registrations)
    vehicles = []

    registrations.each do |vehicle_details|
      vehicle = Vehicle.new(vehicle_details)
      vehicles << vehicle
    end

    return vehicles
  end

end