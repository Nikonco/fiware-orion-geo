require 'httparty'
require 'pp'

module Orion
  class Geo

    def initialize
      config = Orion::Config::load_config('http://192.168.99.100:32769')
      @url = config[:orion_url]
    end

    # type = type of data E.g: 'City'
    # id = id of the element
    # long = Longitude
    # lat = latitude
    def push(type,id,long,lat)
      action = '/ngsi10/updateContext'

      options = {
          body: {
              contextElements: [
                {
                  type: type,
                  isPattern: "false",
                  id: id,
                  attributes: [
                  {
                    name: "position",
                    type: "coords",
                    value: "#{lat}, #{long}",
                    metadatas: [
                      {
                        name: "location",
                        type: "string",
                        value: "WSG84"
                      }
                    ]
                  }
                ]
              }
              ],
              updateAction: "APPEND"
            }.to_json,
          headers: { 'Content-Type' => 'application/json' }
          }

      HTTParty.post(@url + action, options)
    end

    # type = type of data E.g: 'City'
    # type_area = 'circle' || 'polygon'
    #   - polygon: array_point = ['lat, long','lat, long','lat, long'] ----- infinite number of points
    #   - circle: array_point = ['lat, long, radius'] ----- radius in meters
    def pull(type, type_area, array_point)
      action = '/ngsi10/queryContext'

      options = {
          body: {
          entities: [
            {
              type: type,
              isPattern: "true",
              id: ".*"
            }
          ],
          restriction: {
            scopes: [
              {
                type: "FIWARE::Location",
                value: get_area(type_area, array_point)
              }
            ]
          }
        }.to_json,
        headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      }

      HTTParty.post(@url + action, options)
    end

    # type = type of data E.g: 'City'
    # id = id of the object
    def delete(type, id)
      action = '/ngsi10/updateContext'

      options = {
        body: {
          contextElements: [
            {
              type: type,
              isPattern: "false",
              id: id
            }
          ]
        }.to_json,
        headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
      }

      HTTParty.post(@url + action, options)
    end

    # type_area = 'circle' || 'polygon'
    #   - polygon: array_point = ['lat, long','lat, long','lat, long'] ----- infinite number of points
    #   - polygon: array_point = [lat, long, radius] ----- radius in meters
    private
    def get_area(type_area, array_point)
      if type_area == 'circle'
        area = {
            circle: {
                centerLatitude: array_point[0],
                centerLongitude: array_point[1],
                radius: array_point[2]
            }
        }
      else
        area = {
            polygon: {
                vertices:
                array_point.map{ |c|
                  c = c.split(',')
                  {
                      latitude: c[0],
                      longitude: c[1]
                  }
                }
            }
        }
      end
      area
    end
  end
end