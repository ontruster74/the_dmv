class FacilityFactory
  
  def create_facilities(facility_data)
    facilities = []

    facility_data.each do |facility_details|
      facility = Facility.new(facility_details)
      facilities << facility
    end

    return facilities
  end

end