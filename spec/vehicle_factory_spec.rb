require 'spec_helper'
require 'rspec'

describe VehicleFactory do
  describe '#create_vehicles' do
    it 'can create vehicles from external data' do
      factory = VehicleFactory.new
      wa_ev_registrations = DmvDataService.new.wa_ev_registrations
      new_vehicles = factory.create_vehicles(wa_ev_registrations)
      expect(new_vehicles[0].make).to eq("BMW")
      expect(new_vehicles[0].model).to eq("i3")
      expect(new_vehicles[0].vin).to eq("WBY8P8C51K")
      expect(new_vehicles[0].year).to eq("2019")
      expect(new_vehicles[0].engine).to eq(:ev)
      expect(new_vehicles[0].plate_type).to eq(nil)
      expect(new_vehicles[0].registration_date).to eq(nil)
    end
  end
end