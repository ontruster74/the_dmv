require 'spec_helper'
require 'rspec'

describe FacilityFactory do
  describe '#create_facilities' do
    it 'can create facilities from external data (Colorado)' do
      factory = FacilityFactory.new
      co_dmv_office_locations = DmvDataService.new.co_dmv_office_locations
      colorado_facilities = factory.create_facilities(co_dmv_office_locations)

      facility_zero = colorado_facilities[0]
      expect(facility_zero).to be_a(Facility)
      expect(facility_zero.name).to eq("DMV Tremont Branch")
      expect(facility_zero.address).to eq("2855 Tremont Place Suite 118 Denver CO 80205")
      expect(facility_zero.phone).to eq("(720) 865-4600")
      expect(facility_zero.services).to eq([])
      expect(facility_zero.collected_fees).to eq(0)
      expect(facility_zero.registered_vehicles).to eq([])

      facility_one = colorado_facilities[1]
      expect(facility_one).to be_a(Facility)
      expect(facility_one.name).to eq("DMV Northeast Branch")
      expect(facility_one.address).to eq("4685 Peoria Street Suite 101 Denver CO 80239")
      expect(facility_one.phone).to eq("(720) 865-4600")
      expect(facility_one.services).to eq([])
      expect(facility_one.collected_fees).to eq(0)
      expect(facility_one.registered_vehicles).to eq([])
    end

    it 'can create facilities from external data (New York)' do
      factory = FacilityFactory.new
      ny_dmv_office_locations = DmvDataService.new.ny_dmv_office_locations
      new_york_facilities = factory.create_facilities(ny_dmv_office_locations)
      
      facility_zero = new_york_facilities[0]
      expect(facility_zero).to be_a(Facility)
      expect(facility_zero.name).to eq("LAKE PLACID COUNTY OFFICE")
      expect(facility_zero.address).to eq("2693 MAIN STREET LAKE PLACID NY 12946")
      expect(facility_zero.phone).to eq(nil)
      expect(facility_zero.services).to eq([])
      expect(facility_zero.collected_fees).to eq(0)
      expect(facility_zero.registered_vehicles).to eq([])

      facility_one = new_york_facilities[1]
      expect(facility_one).to be_a(Facility)
      expect(facility_one.name).to eq("HUDSON COUNTY OFFICE")
      expect(facility_one.address).to eq("560 WARREN STREET HUDSON NY 12534")
      expect(facility_one.phone).to eq("5188283350")
      expect(facility_one.services).to eq([])
      expect(facility_one.collected_fees).to eq(0)
      expect(facility_one.registered_vehicles).to eq([])
    end

    it 'can create facilities from external data (Missouri)' do
      factory = FacilityFactory.new
      mo_dmv_office_locations = DmvDataService.new.mo_dmv_office_locations
      missouri_facilities = factory.create_facilities(mo_dmv_office_locations)

      facility_zero = missouri_facilities[0]
      expect(facility_zero).to be_a(Facility)
      expect(facility_zero.name).to eq("Harrisonville")
      expect(facility_zero.address).to eq("2009 Plaza Dr. Harrisonville MO 64701")
      expect(facility_zero.phone).to eq("(816) 884-4133")
      expect(facility_zero.services).to eq([])
      expect(facility_zero.collected_fees).to eq(0)
      expect(facility_zero.registered_vehicles).to eq([])

      facility_one = missouri_facilities[1]
      expect(facility_one).to be_a(Facility)
      expect(facility_one.name).to eq("Versailles")
      expect(facility_one.address).to eq("108 N Monroe Versailles MO 65084")
      expect(facility_one.phone).to eq("(573) 378-7434")
      expect(facility_one.services).to eq([])
      expect(facility_one.collected_fees).to eq(0)
      expect(facility_one.registered_vehicles).to eq([])
    end
  end

end