class Facility
  attr_reader :name, :address, :phone, :services, :collected_fees, :registered_vehicles

  def initialize(facility_details)
    if facility_details.keys.include?(:dmv_office)
      @name = facility_details[:dmv_office]
    elsif facility_details.keys.include?(:office_name)
      @name = [facility_details[:office_name], facility_details[:office_type]].join(" ")
    else
      @name = facility_details[:name]
    end

    if facility_details.keys.include?(:address_li)
      @address = [facility_details[:address_li], facility_details[:address__1], facility_details[:city], facility_details[:state], facility_details[:zip]].join(" ")
    elsif facility_details.keys.include?(:street_address_line_1)
      @address = [facility_details[:street_address_line_1], facility_details[:city], facility_details[:state], facility_details[:zip_code]].join(" ")
    elsif facility_details.keys.include?(:address1)
      @address = [facility_details[:address1], facility_details[:city], facility_details[:state], facility_details[:zipcode]].join(" ")
    else
      @address = facility_details[:address]
    end

    if facility_details.keys.include?(:public_phone_number)
      @phone = facility_details[:public_phone_number]
    else
      @phone = facility_details[:phone]
    end
    
    @services = []
    @registered_vehicles = []
    @collected_fees = 0
  end

  def add_service(service)
    @services << service
  end

  def register_vehicle(vehicle)
    if (services.include?('Vehicle Registration'))
      vehicle.registration_date = Date.today
      @registered_vehicles << vehicle 

      if vehicle.antique?
        vehicle.plate_type = :antique
        @collected_fees += 25
      elsif vehicle.electric_vehicle?
        vehicle.plate_type = :ev
        @collected_fees += 200
      else
        vehicle.plate_type = :regular
        @collected_fees += 100
      end

    else
      return nil
    end
  end

  def administer_written_test(registrant)
    if services.include?('Written Test')
      if (registrant.permit? == true && registrant.age >= 16)
        registrant.license_data[:written] = true
      end
    end
    return registrant.license_data[:written]
  end

  def administer_road_test(registrant)
    if services.include?('Road Test')
      if registrant.license_data[:written] == true
        registrant.license_data[:license] = true
      end
    end
    return registrant.license_data[:license]
  end

  def renew_drivers_license(registrant)
    if services.include?('Renew Drivers License')
      if registrant.license_data[:license] == true
        registrant.license_data[:renewed] = true
      end
    end
    return registrant.license_data[:renewed]
  end

end
