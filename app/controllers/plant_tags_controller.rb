class PlantTagsController < ApplicationController
    def new
      @plant = Plant.find(params[:plant_id])
      @plant_tag = PlantTag.new
    end

    # creates associations between a specific Plant and multiple Tag objects. It iterates over each selected
    # tag, creates a new PlantTag object with the given Plant and Tag, saves it to the database, and finally
    # redirects the user to the garden page of the associated Plant object

    def create
      # retrieve a specific Plant object from the database based on the "plant_id" parameter passed to the method
      @plant = Plant.find(params[:plant_id])
      # retrieves Tag objects from the database based on the "tag" parameter within the "plant_tag" parameter
      @tags = Tag.where(id: params[:plant_tag][:tag])
      # starts a loop, iterating over each Tag object stored in the "@tags" collection
      @tags.each do |tag|
        # creates a new PlantTag object, associating the current Plant object "@plant" with the current Tag object "tag" 
        plant_tag = PlantTag.new(plant: @plant, tag: tag)
        # saves the newly created PlantTag object to the database
        plant_tag.save
      end
      # redirects the user to the garden page associated with the Plant object's garden
      redirect_to garden_path(@plant.garden)
    end
end
