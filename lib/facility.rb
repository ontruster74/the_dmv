class Facility
  attr_reader :name, :address, :phone, :services, :collected_fees, :registered_vehicle

  def initialize(facility_details)
    @name = facility_details[:name]
    @address = facility_details[:address]
    @phone = facility_details[:phone]
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle 
    
  end

  def administer_written_test(registrant)
    
  end

  def administer_road_test(registrant)
    
  end

  def renew_drivers_license(registrant)
    
  end

end
