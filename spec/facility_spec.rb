require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
    @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
    @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
    @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
    @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )
    @registrant_1 = Registrant.new('Bruce', 18, true)
    @registrant_2 = Registrant.new('Penny', 16)
    @registrant_3 = Registrant.new('Tucker', 15)
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@facility_1).to be_an_instance_of(Facility)
      expect(@facility_1.name).to eq('DMV Tremont Branch')
      expect(@facility_1.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility_1.phone).to eq('(720) 865-4600')
      expect(@facility_1.services).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility_1.services).to eq([])
      @facility_1.add_service('New Drivers License')
      @facility_1.add_service('Renew Drivers License')
      @facility_1.add_service('Vehicle Registration')
      expect(@facility_1.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe '#register_vehicle' do
    it 'can register a vehicle' do
      @facility_1.add_service('Vehicle Registration')
      expect(@cruz.registration_date).to eq(nil)
      expect(@facility_1.registered_vehicles).to eq([])
      expect(@facility_1.collected_fees).to eq(0)
      @facility_1.register_vehicle(@cruz)
      expect(@cruz.registration_date).to be_a(Date)
      expect(@cruz.plate_type).to eq(:regular)
      expect(@facility_1.registered_vehicles).to eq([@cruz])
      expect(@facility_1.collected_fees).to eq(100)
    end

    it 'can register multiple vehicles at a single facility' do
      @facility_1.add_service('Vehicle Registration')
      @facility_1.register_vehicle(@cruz)
      @facility_1.register_vehicle(@camaro)
      expect(@camaro.registration_date).to be_a(Date)
      expect(@camaro.plate_type).to eq(:antique)
      @facility_1.register_vehicle(@bolt)
      expect(@bolt.registration_date).to be_a(Date)
      expect(@bolt.plate_type).to eq(:ev)
      expect(@facility_1.registered_vehicles).to eq([@cruz, @camaro, @bolt])
      expect(@facility_1.collected_fees).to eq(325)
    end

    it 'cannot register vehicles if service not offered' do
      @facility_1.add_service('Vehicle Registration')
      expect(@facility_2.register_vehicle(@bolt)).to eq(nil)
      expect(@facility_2.registered_vehicles).to eq([])
      expect(@facility_2.collected_fees).to eq(0)
    end
  end

  describe '#administer_written_test' do
    it 'can give written tests' do
      @facility_1.add_service('Written Test')
      expect(@registrant_1.license_data[:written]).to eq(false)
      expect(@facility_1.administer_written_test(@registrant_1)).to eq(true)
      expect(@registrant_1.license_data[:written]).to eq(true)
    end

    it 'cannot give written tests if service not offered' do
      expect(@registrant_1.license_data[:written]).to eq(false)
      expect(@facility_1.administer_written_test(@registrant_1)).to eq(false)
      expect(@registrant_1.license_data[:written]).to eq(false)
    end

    it 'can give written tests to drivers 16 and older who earn a permit' do
      @facility_1.add_service('Written Test')
      expect(@registrant_2.age).to eq(16)
      expect(@registrant_2.permit?).to eq(false)
      @registrant_2.earn_permit
      expect(@facility_1.administer_written_test(@registrant_2)).to eq(true)
      expect(@registrant_2.license_data[:written]).to eq(true)
    end

    it 'cannot give written tests to drivers under 16 even with a permit' do
      @facility_1.add_service('Written Test')
      expect(@registrant_3.age).to eq(15)
      expect(@registrant_3.permit?).to eq(false)
      @registrant_3.earn_permit
      expect(@facility_1.administer_written_test(@registrant_3)).to eq(false)
      expect(@registrant_3.license_data[:written]).to eq(false)
    end
  end

  describe '#administer_road_test' do
    it 'can give road tests to drivers who have passed written test' do
      @facility_1.add_service('Road Test')
      @facility_1.add_service('Written Test')
      @facility_1.administer_written_test(@registrant_1)
      expect(@registrant_1.license_data[:written]).to eq(true)
      expect(@facility_1.administer_road_test(@registrant_1)).to eq(true)
    end

    it 'gives licenses to drivers who pass the road test' do
      @facility_1.add_service('Road Test')
      @facility_1.add_service('Written Test')
      @facility_1.administer_written_test(@registrant_1)
      @facility_1.administer_road_test(@registrant_1)
      expect(@registrant_1.license_data[:license]).to eq(true)
    end

    it 'cannot give road tests to drivers with no written test' do
      @facility_1.add_service('Road Test')
      @facility_1.add_service('Written Test')
      expect(@registrant_1.license_data[:written]).to eq(false)
      expect(@facility_1.administer_road_test(@registrant_1)).to eq(false)
    end

    it 'cannot give road tests if service not offered' do
      @facility_1.add_service('Written Test')
      @facility_1.administer_written_test(@registrant_1)
      expect(@facility_1.administer_road_test(@registrant_1)).to eq(false)
    end
  end

  describe '#renew_drivers_licence' do
    it 'can renew licenses' do
      @facility_1.add_service('Renew Drivers License')
      @facility_1.add_service('Road Test')
      @facility_1.add_service('Written Test')
      @facility_1.administer_written_test(@registrant_1)
      @facility_1.administer_road_test(@registrant_1)
      expect(@registrant_1.license_data[:renewed]).to eq(false)
      expect(@facility_1.renew_drivers_license(@registrant_1)).to eq(true)
      expect(@registrant_1.license_data[:renewed]).to eq(true)
    end

    it 'cannot renew licenses for drivers without a license' do
      @facility_1.add_service('Renew Drivers License')
      @facility_1.add_service('Road Test')
      @facility_1.add_service('Written Test')
      expect(@registrant_1.license_data[:license]).to eq(false)
      expect(@registrant_1.license_data[:renewed]).to eq(false)
      expect(@facility_1.renew_drivers_license(@registrant_1)).to eq(false)
      expect(@registrant_1.license_data[:renewed]).to eq(false)
    end

    it 'cannot renew licenses if service not offered' do
      @facility_1.add_service('Road Test')
      @facility_1.add_service('Written Test')
      @facility_1.administer_written_test(@registrant_1)
      @facility_1.administer_road_test(@registrant_1)
      expect(@registrant_1.license_data[:license]).to eq(true)
      expect(@registrant_1.license_data[:renewed]).to eq(false)
      expect(@facility_1.renew_drivers_license(@registrant_1)).to eq(false)
      expect(@registrant_1.license_data[:renewed]).to eq(false)
    end
  end

end
