class Api::V1::StoresController < Api::V1::ApplicationController
	# before_action :authenticate_user!
	before_action :set_store, only: [:items]

	# List of all stores as per postal code
	def index
		begin
			if params[:lat].present? && params[:lng].present?
				@address = Geokit::Geocoders::GoogleGeocoder.reverse_geocode "#{params[:lat]},#{params[:lng]}"
				params[:postal_code] = @address.try(:zip) if @address.success
			end
			@search = Store.search(include: [:open_hours]) do
				fulltext(params[:postal_code]) do
					fields(:postal_code)
				end
			end
			puts @search.results.first.name
			if @address.present?
				@stores = @search.results.sort_by{|s| s.distance_to([@address.lat,@address.lng])}
			else
				@stores = @search.results
			end
				@postal_code = params[:postal_code]
				@stores =	@stores.first(5) if params[:type] == "collection"
			render :index, status: :ok
		rescue Exception => e
			error_handling_bad_request(e)
		end
	end
	# Display all store categories	
	def categories
		begin
			@categories = Category.select(:id, :name)
			render json: @categories
		rescue Exception => e
			error_handling_bad_request(e)
		end
	end

  # Display all store items including regular dimensions and item dimensions	
  def items
  	begin
  	@categories = Category.all.includes(items: [:dimensions,:picture,:store_items])
  	@ingredients = Ingredient.actives
  	@toppings = Topping.actives
  	render  'api/v1/home/items', status: :ok
  	rescue Exception => e
  		error_handling_bad_request(e)
  	end

	end
	# All cutomization items like toppings
	def customization
		begin
			@ingredients = Ingredient.actives
			@toppings = Topping.actives
		rescue Exception => e
			error_handling_bad_request(e)
		end
	end


	private

	def set_store
		@store  = Store.find(params[:id]) if params[:id].present?
		@store  = Store.find(params[:store_id]) if params[:store_id].present?
	end
end