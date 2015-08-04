require 'httparty'
require 'pp'

module Orion
  class Geo



    def push(type,id,long,lat)
      action = '/v1/updateContext'

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
                        value: "WGS84"
                      }
                    ]
                  }
                ]
              }
              ],
              updateAction: "APPEND"
            },
          headers: { 'Content-Type' => 'application/json' }
          }

      response = HTTParty.post(ORION_GEO_URL + action, options)
      puts response.body, response.code, response.message, response.headers.inspect
    end

    def pull(type,array_point)
      puts "Note #{id} located on long #{long} and lat #{lat}"
    end

  end
end