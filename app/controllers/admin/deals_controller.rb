class Admin::DealsController < ApplicationController
  before_action :set_deal, only: [:show, :edit, :update, :destroy]

  # GET /admin/deals
  # GET /admin/deals.json
  def index
    @deals = Deal.all
  end

  # GET /admin/deals/1
  # GET /admin/deals/1.json
  def show
  end

  # GET /admin/deals/new
  def new
    @deal = Deal.new
  end

  # GET /admin/deals/1/edit
  def edit
  end

  # POST /admin/deals
  # POST /admin/deals.json
  def create
    @deal = Deal.new(deal_params)

    respond_to do |format|
      if @deal.save
        @deal.build_picture(image: params[:deal][:image]).save!
        format.html { redirect_to [:admin, @deal], notice: 'Deal was successfully created.' }
        format.json { render action: 'show', status: :created, location: @deal }
      else
        format.html { render action: 'new' }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/deals/1
  # PATCH/PUT /admin/deals/1.json
  def update
    respond_to do |format|
      if @deal.update(deal_params)
        @deal.build_picture(image: params[:deal][:image]).save!
        format.html { redirect_to [:admin, @deal], notice: 'Deal was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/deals/1
  # DELETE /admin/deals/1.json
  def destroy
    @deal.destroy
    respond_to do |format|
      format.html { redirect_to admin_deals_url, notice: 'Deal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deal
      @deal = Deal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deal_params
      params.require(:deal).permit(:price_id, :name, :initial_time, :end_time, :description, :amount)
    end
end
