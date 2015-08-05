require 'spec_helper'

describe 'Endpoints Orion server' do

  before(:each) do
    @sut = Orion::Geo.new
  end

  describe 'Store geolocalisation data for object' do

    context 'build a area' do
      it 'should return circle' do
        actual = @sut.instance_eval{get_area('circle', [2,3,2])}
        expected = {circle: {centerLatitude: 2, centerLongitude: 3, radius: 2}}
        expect(actual).to eq(expected)
      end

      it 'should return a polygon' do
        actual = @sut.instance_eval{get_area('polygon', ['1,2','4,5','3,2'])}
        expected = {polygon: {vertices: [{ latitude: '1', longitude: '2' }, { latitude: '4', longitude: '5' },{ latitude: '3', longitude: '2'}]}}
        expect(actual).to eq(expected)
      end

    end
  end
end