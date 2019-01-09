class Admin::ItemDimensionsController < ApplicationController
  before_action :set_item_dimension, only: [:show, :edit, :update, :destroy]

  # GET /admin/item_dimensions
  # GET /admin/item_dimensions.json
  def index
    @item_dimensions = ItemDimension.all
  end

  # GET /admin/item_dimensions/1
  # GET /admin/item_dimensions/1.json
  def show
  end

  # GET /admin/item_dimensions/new
  def new
    @item_dimension = ItemDimension.new
  end

  # GET /admin/item_dimensions/1/edit
  def edit
  end

  # POST /admin/item_dimensions
  # POST /admin/item_dimensions.json
  def create
    @item_dimension = ItemDimension.new(item_dimension_params)

    respond_to do |format|
      if @item_dimension.save
        format.html { redirect_to [:admin, @item_dimension], notice: 'Item dimension was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item_dimension }
      else
        format.html { render action: 'new' }
        format.json { render json: @item_dimension.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/item_dimensions/1
  # PATCH/PUT /admin/item_dimensions/1.json
  def update
    respond_to do |format|
      if @item_dimension.update(item_dimension_params)
        format.html { redirect_to [:admin, @item_dimension], notice: 'Item dimension was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item_dimension.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/item_dimensions/1
  # DELETE /admin/item_dimensions/1.json
  def destroy
    @item_dimension.destroy
    respond_to do |format|
      format.html { redirect_to admin_item_dimensions_url, notice: 'Item dimension was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_dimension
      @item_dimension = ItemDimension.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_dimension_params
      params.require(:item_dimension).permit(:item_id, :dimension_id, :price)
    end
end
