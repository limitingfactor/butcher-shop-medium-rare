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
    @animal = Animal.find(params[:id])
    respond_with @animal
  rescue ActiveRecord::RecordNotFound
    head 404
  end

  def update
    @animal = Animal.find(params[:id])
    @animal.update_attributes animal_params
    respond_with @animal
  end

  def destroy
    @animal = Animal.find(params[:id])
    @animal.destroy
    head 204
  end

  protected
    def animal_params
      params.require(:animal).permit(:name)
    end
end
