# this is just a little condition that will destroy all of our gardens
# if the rails app is in a development environment before reseeding with the data below.
Garden.destroy_all if Rails.env.development?

# first we will want our seed to build us some gardens which we can save to a variable
# to reference when we create our plants after

versaille = Garden.create!(
  name: "Gardens of Versaille",
  banner_url: "https://assets.gocity.com/files/paris_pass/files/styles/crop_freeform/public/blog/new2mp.jpg"
)

new_york = Garden.create!(
  name: "New York Botannical Gardens",
  banner_url: "https://imageio.forbes.com/blogs-images/micheleherrmann/files/2019/02/NYBGTheOrchidShowSingapore-Arches-MCOB0807-1200x800.jpg?format=jpg&width=1200"
)

# Now let's create some plants

Plant.create!(
  name: "Virginia Bluebell",
  image_url: "https://images.unsplash.com/photo-1653672656337-abf58ebc4a28?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
  garden: new_york
)

Plant.create!(
  name: "Corsican Pine",
  image_url: "https://www.the-forest-time.com/media/cache/article_main/images/c7fa981a-3605-4bfb-ab95-8a014ce1894b.jpg",
  garden: versaille
)

Plant.create!(
  name: "Orchid",
  image_url: "https://images.unsplash.com/photo-1582862058398-c157c8424b54?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=327&q=80",
  garden: new_york
)

# Tags

Tag.destroy_all if Rails.env.development?

tags = %w(Fruit Tree Plant Flower Fern)

tags.each do |name|
  Tag.create!(name: name)
end