class Api::BuyersController < ApplicationController
  def show
    buyer = Buyer.find(params[:id])
    render json: Buyer.my_homes(buyer.id, buyer.cities)
  end
end
