class Buyer < ApplicationRecord
  belongs_to :agent
  serialize :cities, Array  #in the database this is just text, if we serialize it then it is treated like an array so we can use it. 
                            # this works well if it is an array of one thing (cities, cars, etc) NOT good for an array of objects
# homes for a buyer in the city and price range they are interested in.
  def self.my_homes(id, cities)
    select('p.id, price, city, street, sq_ft')
      .joins("INNER JOIN agents a ON a.id = buyers.agent_id 
              INNER JOIN properties p ON p.agent_id = a.id
                AND p.price <= buyers.max_price
              INNER JOIN addresses ad ON ad.property_id = p.id
                AND city = ANY ('{#{cities.join(',') }}')
            ")
      .where('buyers.id = ? AND p.sold <> TRUE', id)
      .order('price DESC')
  end
end
