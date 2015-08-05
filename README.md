# fiware-orion-geo
Interface to dialog with Orion server from Fiware (Geolocalization)

# Config

Dependencies:
  HTTPParty - https://rubygems.org/gems/httparty

To configure the gem create the file config/initializers/fiware_orion_config.rb and add the configuration of the client.

Example:

```ruby
Rails.application.config.after_initialize do
  ORION_SERVER_IP = {Your Orion server address} unless defined?(ORION_SERVER_IP)

  Orion::Config.load_config(ORION_SERVER_IP)
end
```

# Installation

Add to your Gemfile:

`gem 'qq_client'`

Then bundle install

Or install it yourself as:

`$ gem install qq_client`

# Usage

* type = type of object stored E.g:'Cars', 'Houses', 'Fruits'... - String
* id = identifier of the object - String
* type_area = can be 'polygon' or 'circle' - String
  * circle: array_point = ['lat', 'long', 'radius'] ----- radius in meters 
  * polygon: array_point = ['lat, long','lat, long','lat, long'] ----- infinite number of points


`Orion::Geo.new`

INSERT
`def push(type, id, long, lat)`

SELECT
`def pull(type, type_area, array_point)`

DELETE
`def delete(type, id)`

UPDATE = To update you have to delete the object then create a new one (REF: Fiware documentation)


# Contributing
