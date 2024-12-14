class Facility
  attr_reader :name, :address, :phone, :services, :collected_fees, :registered_vehicles

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

  def register_vehicle(vehicle)
    @registered_vehicles << vehicle 
    if vehicle.age >= 25
      @collected_fees += 25
      vehicle.plate_type = :antique
    elsif vehicle.engine == :ev
      @collected_fees += 200
      vehicle.plate_type = :ev
    else
      @collected_fees += 100
      vehicle.plate_type = :regular
    end
  end

  def administer_written_test(registrant)
    if services.include?('Written Test')
      if (registrant.permit == true && registrant.age >= 16)
        registrant.license_data[:written] = true
      end
      return registrant.license_data[:written]
    else
      return false
    end
  end

  def administer_road_test(registrant)
    if services.include?('Road Test')
      if registrant.license_data[:written] = true
        registrant.license_data[:license] = true
      end
      return registrant.license_data[:license]
    else
      return false
    end
  end

  def renew_drivers_license(registrant)
    if services.include?('Renew Drivers License')
      if registrant.license_data[:license] = true
        registrant.license_data[:renewed] = true
      end
      return registrant.license_data[:renewed]
    else
      return false
    end
  end

end
