class Api::V1::DealsController < Api::V1::ApplicationController
	before_action :set_deal, only: [:apply]
	def index
		begin
			@deals = Deal.active.includes(:price,:picture)
		rescue Exception => e
			error_handling_bad_request(e)
		end
	end

	def apply
		begin
			
		rescue Exception => e
			error_handling_bad_request(e)
		end
	end

	private

	def set_deal
		@deal = Deal.find(params[:id]) if params[:id].present?
		@deal = Deal.find(params[:deal_id]) if params[:deal_id].present?
	end

end