require 'pry'

class Application

  attr_accessor :item

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      search_term = req.path.split("/").last
        item_object= @@items.select do |item|
          item.name == search_term
        end
        if item_object[0]
            resp.write "#{item_object[0].price}"
        else
            resp.write "Item not found"
            resp.status = 400
        end

      else
        resp.write "Route not found"
        resp.status = 404
      end

    resp.finish
  end
end

#   def handle_search(search_term)
#     if @@items.include?(search_term)
#       return "#{search_term} is one of our items"
#     else
#       return "Couldn't find #{search_term}"
#     end
#   end
# end
