class PrimalCutsController < ApplicationController
  respond_to :json

  before_filter :find_animal,     :only   => [:index, :create]
  before_filter :find_primal_cut, :except => [:index, :create]

  def index
    @primal_cuts = @animal.primal_cuts.all
    respond_with @primal_cuts
  end

  def create
    @primal_cut = @animal.primal_cuts.create(primal_cut_params)
    respond_with @primal_cut
  end

  def show
    respond_with @primal_cut
  end

  def update
    @primal_cut.update_attributes primal_cut_params
    respond_with @primal_cut
  end

  def destroy
    @primal_cut.destroy
    head 204
  end

  protected
    def find_animal
      @animal = Animal.find params[:animal_id]
    rescue ActiveRecord::RecordNotFound
      head 404
    end

    def find_primal_cut
      @primal_cut = PrimalCut.find params[:id]
    rescue ActiveRecord::RecordNotFound
      head 404
    end

    def primal_cut_params
      params.require(:primal_cut).permit(:name)
    end
end
