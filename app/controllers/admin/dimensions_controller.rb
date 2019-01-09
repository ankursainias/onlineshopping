class Admin::DimensionsController < ApplicationController
  before_action :set_dimension, only: [:show, :edit, :update, :destroy]

  # GET /admin/dimensions
  # GET /admin/dimensions.json
  def index
    @dimensions = Dimension.all
  end

  # GET /admin/dimensions/1
  # GET /admin/dimensions/1.json
  def show
  end

  # GET /admin/dimensions/new
  def new
    @dimension = Dimension.new
  end

  # GET /admin/dimensions/1/edit
  def edit
  end

  # POST /admin/dimensions
  # POST /admin/dimensions.json
  def create
    @dimension = Dimension.new(dimension_params)

    respond_to do |format|
      if @dimension.save
        format.html { redirect_to [:admin, @dimension], notice: 'Dimension was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dimension }
      else
        format.html { render action: 'new' }
        format.json { render json: @dimension.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/dimensions/1
  # PATCH/PUT /admin/dimensions/1.json
  def update
    respond_to do |format|
      if @dimension.update(dimension_params)
        format.html { redirect_to [:admin, @dimension], notice: 'Dimension was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dimension.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/dimensions/1
  # DELETE /admin/dimensions/1.json
  def destroy
    @dimension.destroy
    respond_to do |format|
      format.html { redirect_to admin_dimensions_url, notice: 'Dimension was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dimension
      @dimension = Dimension.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dimension_params
      params.require(:dimension).permit(:size, :serve)
    end
end
