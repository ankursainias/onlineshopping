class Api::V1::ItemsController < Api::V1::ApplicationController
	before_action :set_item,:set_store, only: [:show]

	def show
		@toppings = Topping.all
	end

	private

	def set_item
		@item = Item.find(params[:id])
	end

	def set_store
		@store = Store.find(params[:store_id])
	end

end