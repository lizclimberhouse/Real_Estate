class Api::AgentsController < ApplicationController
  # lets make it more interesting by (instead of just Agent.all) lets order them by the agaents that have the most unsold homes to the least.
  def index
    render json: Agent.unsold_homes
  end

  def show
    render json: Agent.find(params[:id]).buyers
  end
end
