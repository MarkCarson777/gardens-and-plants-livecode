GARDENS AND PLANTS PART 2

1. Set root page of app to the gardens#index in routes.rb

 root to: "gardens#index"


2. Build your seed file in db/seeds.rb


3. Generate the Tag model with the appropriate attributes

rails g model Tag name


4. Generate the JOIN table model with the correct naming convention (alphabetical order) and
give it the id's of both of the tables it is joining.

rails g model plant_tag plant:references tag:references


5. Update your schema with the new models

rails db:migrate


6. Add the appropriate associations and validations to both the plant and tag models

# plant.rb
has_many :plant_tags, dependent: :destroy
has_many :tags, through: :plant_tags

# tag.rb
has_many :plant_tags, dependent: :destroy
has_many :plants, through: :plant_tags


7. Build the skeleton of your test in tests/model/tag_test.rb

  test 'valid tag' do
  end

  test 'invalid without name' do
  end


8. Run the test to make sure it's functioning

rails test:models 


9. Add the test assertions

def setup
  @tag = Tag.new(name: "Flower")
end

test 'valid tag' do
  assert @tag.valid?
end

test 'invalid without name' do
  @tag.name = nil
  refute @tag.valid?, "saved tag without a name"
  assert_not_nil @tag.errors[:name], "no validation error for name not present"
end


10. Run the test again

rails test:models


11. Fix the error by adding a new validation in the Tag model

validates :name, presence: true


12. Make sure the test passes

rails test:models


13. Add some code to your seed file to generate some tags for your app

Tag.destroy_all if Rails.env.development?

tags = %w(Fruit Tree Plant Flower Fern)

tags.each do |name|
  Tag.create!(name: name)
end


14. Seed your application with the new tags

rails db:seed


15. Check if they were created in the rails console

rails c

Tag.all


16. Add some new routes for plant_tag in routes.rb


17. Generate a new controller to handle our plant_tags

rails g controller plant_tags


18. Implement the new action in the plant_tag controller

def new
  @plant = Plant.find(params[:plant_id])
  @plant_tag = PlantTag.new
end


19. Create new.html.erb in your views and add the form to create our tags


<div class="container">
  <div class="row justify-content-center">
    <div class="col-12 col-md-8">
      <h1>Add new tag for <%= @plant.name %></h1>

      <%= simple_form_for [@plant, @plant_tag] do |f| %>
        <%= f.input :tag, collection: Tag.all %>
        <%= f.submit "Add tag", class: 'btn btn-primary' %>
      <% end %>
    </div>
  </div>
</div>


20. Display your tags on the plant cards with a link to our new page in gardens#show

<div class="card-tags">
  <% plant.tags.each do |tag| %>
    <span><%= tag.name %></span>
  <% end %>
  <%= link_to "+", new_plant_plant_tag_path(plant) %>
</div>


21. Add the create action in your plant_tag controller and use "raise" to check params

def create
  @plant = Plant.find(params[:plant_id])
  @tag = Tag.find(params[:plant_tag][:tag])
  @plant_tag = PlantTag.new(plant: @plant, tag: @tag)
  @plant_tag.save
  redirect_to garden_path(@plant.garden)
end


22. Add a new validation in your model to prevent creating the same tag twice

validates :tag, uniqueness: {scope: :plant, message: "already added"}


23. Update our controller 

if @plant_tag.save
  redirect_to garden_path(@plant.garden)
else
  render :new, status: :unprocessable_entity
end

This will redirect us back to our show page if it saves or refresh the page with our error message if it fails.


24. We can add some options in our simple_form to allow for multiple select in our plant_tag new page.

<%= f.input :tag, collection: Tag.all, input_html: {multiple: true, class: "multiple-select"}, include_hidden: false %>


25. Fix the error by updating the create action in the controller

def create
  @plant = Plant.find(params[:plant_id])
  @tags = Tag.where(id: params[:plant_tag][:tag])
  @tags.each do |tag|
    plant_tag = PlantTag.new(plant: @plant, tag: tag)
    plant_tag.save
  end
  redirect_to garden_path(@plant.garden)
end


26. We can now select multiple tags at once


27. Improve UI (user interface) by installing some javascript packages

yarn add tom-select

Then launch the webpack server

yarn build --watch


28. Create a stimulus controller to handle the javascript package

rails g stimulus tom_select


29. Import the package into the controller

import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

export default class extends Controller {
  connect() {
    new TomSelect(this.element, {})
  }
}


30. Import the package into our application.scss: 

@import "tom-select/dist/css/tom-select.css";


31. Finally, connect it to our select input in plant_tags#new

<%= f.input :tag,
  collection: Tag.all,
  input_html: {multiple: true, data: {controller: "tom-select"}},
  include_hidden: false
%>