class AnimalsController < ApplicationController
  respond_to :json

  def index
    @animals = Animal.all
    respond_with @animals
  end

  def create
    @animal = Animal.create animal_params
    respond_with @animal
  end

  def show
    respond_with @animal
  end

  def update
    @animal.update_attributes animal_params
    respond_with @animal
  end

  def delete
    @animal.destroy
    head 204
  end

  protected
    def animal_params
      params.require(:animal).permit(:name)
    end
end
