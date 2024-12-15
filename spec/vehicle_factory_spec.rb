require 'spec_helper'
require 'rspec'

describe VehicleFactory do
  describe '#create_vehicles' do
    it 'can create vehicles from external data (Washington)' do
      factory = VehicleFactory.new
      wa_ev_registrations = DmvDataService.new.wa_ev_registrations
      washington_vehicles = factory.create_vehicles(wa_ev_registrations)

      vehicle_zero = washington_vehicles[0]
      expect(vehicle_zero).to be_a(Vehicle)
      expect(vehicle_zero.make).to eq("BMW")
      expect(vehicle_zero.model).to eq("i3")
      expect(vehicle_zero.vin).to eq("WBY8P8C51K")
      expect(vehicle_zero.year).to eq("2019")
      expect(vehicle_zero.engine).to eq(:ev)
      expect(vehicle_zero.plate_type).to eq(nil)
      expect(vehicle_zero.registration_date).to eq(nil)

      vehicle_one = washington_vehicles[1]
      expect(vehicle_one).to be_a(Vehicle)
      expect(vehicle_one.make).to eq("FORD")
      expect(vehicle_one.model).to eq("Mustang Mach-E")
      expect(vehicle_one.vin).to eq("3FMTK4SE2P")
      expect(vehicle_one.year).to eq("2023")
      expect(vehicle_one.engine).to eq(:ev)
      expect(vehicle_one.plate_type).to eq(nil)
      expect(vehicle_one.registration_date).to eq(nil)
    end
  end
end