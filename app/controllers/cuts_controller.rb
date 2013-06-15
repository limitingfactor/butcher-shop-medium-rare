class CutsController < ApplicationController
  respond_to :json

  before_filter :find_animal_or_primal_cut, :only   => [:index, :create]
  before_filter :find_cut,                  :except => [:index, :create]

  def index
    @cuts = @parent.cuts.all
    respond_with @cuts
  end

  def create
    @cut = @parent.cuts.create(cut_params)
    respond_with @cut
  end

  def show
    respond_with @cut
  end

  def update
    @cut.update_attributes cut_params
    respond_with @cut
  end

  def destroy
    @cut.destroy
    head 204
  end

  protected
    def find_animal_or_primal_cut
      @parent = params[:animal_id].present? ? Animal.find(params[:animal_id]) : PrimalCut.find(params[:primal_cut_id])
    rescue ActiveRecord::RecordNotFound
      head 404
    end

    def find_cut
      @cut = Cut.find params[:id]
    rescue ActiveRecord::RecordNotFound
      head 404
    end

    def cut_params
      params.require(:cut).permit(:name)
    end
end
