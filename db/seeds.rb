# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


# data = [
#     { name: "product1",price: 100},
#     {name: "product2", price: 200}
# ]
# data.each do|datum|
#     product = Product.new(datum)
#     product.save
# end


(1..100).each do |i|
    Product.create(name: "product#{i}", price: rand(100.00..999.99) )
end