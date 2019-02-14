class Admin::PricesController < ApplicationController
  before_action :set_price, only: [:show, :edit, :update, :destroy]

  # GET /admin/prices
  # GET /admin/prices.json
  def index
    @prices = Price.all
  end

  # GET /admin/prices/1
  # GET /admin/prices/1.json
  def show
  end

  # GET /admin/prices/new
  def new
    @price = Price.new
  end

  # GET /admin/prices/1/edit
  def edit
  end

  # POST /admin/prices
  # POST /admin/prices.json
  def create
    @price = Price.new(price_params)

    respond_to do |format|
      if @price.save
        format.html { redirect_to [:admin, @price], notice: 'Price was successfully created.' }
        format.json { render action: 'show', status: :created, location: @price }
      else
        format.html { render action: 'new' }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/prices/1
  # PATCH/PUT /admin/prices/1.json
  def update
    respond_to do |format|
      if @price.update(price_params)
        format.html { redirect_to [:admin, @price], notice: 'Price was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/prices/1
  # DELETE /admin/prices/1.json
  def destroy
    @price.destroy
    respond_to do |format|
      format.html { redirect_to admin_prices_url, notice: 'Price was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price
      @price = Price.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def price_params
      params.require(:price).permit(:title, :p_type, :active)
    end
end
