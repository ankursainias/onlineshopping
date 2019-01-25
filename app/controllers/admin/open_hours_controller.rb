class Admin::OpenHoursController < ApplicationController
  before_action :set_open_hour, only: [:show, :edit, :update, :destroy]

  # GET /admin/open_hours
  # GET /admin/open_hours.json
  def index
    @open_hours = OpenHour.all
  end

  # GET /admin/open_hours/1
  # GET /admin/open_hours/1.json
  def show
  end

  # GET /admin/open_hours/new
  def new
    @open_hour = OpenHour.new
  end

  # GET /admin/open_hours/1/edit
  def edit
  end

  # POST /admin/open_hours
  # POST /admin/open_hours.json
  def create
    @open_hour = OpenHour.new(open_hour_params)

    respond_to do |format|
      if @open_hour.save
        format.html { redirect_to [:admin, @open_hour], notice: 'Open hour was successfully created.' }
        format.json { render action: 'show', status: :created, location: @open_hour }
      else
        format.html { render action: 'new' }
        format.json { render json: @open_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/open_hours/1
  # PATCH/PUT /admin/open_hours/1.json
  def update
    respond_to do |format|
      if @open_hour.update(open_hour_params)
        format.html { redirect_to [:admin, @open_hour], notice: 'Open hour was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @open_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/open_hours/1
  # DELETE /admin/open_hours/1.json
  def destroy
    @open_hour.destroy
    respond_to do |format|
      format.html { redirect_to admin_open_hours_url, notice: 'Open hour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_open_hour
      @open_hour = OpenHour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def open_hour_params
      params.require(:open_hour).permit(:store_id, :day, :open, :close, :valid_from, :valid_through)
    end
end
