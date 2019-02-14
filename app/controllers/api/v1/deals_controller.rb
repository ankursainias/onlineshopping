class Api::V1::DealsController < Api::V1::ApplicationController

	def index
		@deals = Deal.active
	end
end