class Property < ApplicationRecord
  belongs_to :agent
  has_one :address

  # need to use join not to join but to filter by the join table
  # and we want this to be case-insensative. The LOWER(a.city) is a postgres property
  # the ?, the first thing (after teh comma)
  def self.by_city(city)
    select('properties.id, price, beds, sq_ft')
      .joins('INNER JOIN addresses a ON a.property_id = properties.id')
      .where('LOWER(a.city) = ? AND properties.sold <> TRUE', city.downcase)
  end

  #called in controller liek: Property.available
  #Property.select('...') can do something like this as well, but since we are already in property we can just use self.
  def self.available
    select('properties.id, price, beds, baths, sq_ft, ad.city, ad.street, a.first_name, a.last_name, a.email, a.id AS agent_id')
    .joins('INNER JOIN agents a ON a.id = properties.agent_id
            INNER JOIN addresses ad ON ad.property_id = properties.id')
    .where('properties.sold <> TRUE')
    .order('a.id')
  end
end


# this returns an array of active record objects.
# the .find_by_sql returns an array of objects. use this for not perfect box of active record stuff. Maybe you need it to steal that record from the internet and it doesn't work with active record.

# our objects in our database are active record objects.

