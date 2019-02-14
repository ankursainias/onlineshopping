class Admin::DealItemsController < ApplicationController
  before_action :set_deal_item, only: [:show, :edit, :update, :destroy]

  # GET /admin/deal_items
  # GET /admin/deal_items.json
  def index
    @deal_items = DealItem.all
  end

  # GET /admin/deal_items/1
  # GET /admin/deal_items/1.json
  def show
  end

  # GET /admin/deal_items/new
  def new
    @deal_item = DealItem.new
  end

  # GET /admin/deal_items/1/edit
  def edit
  end

  # POST /admin/deal_items
  # POST /admin/deal_items.json
  def create
    @deal_item = DealItem.new(deal_item_params)

    respond_to do |format|
      if @deal_item.save
        format.html { redirect_to [:admin, @deal_item], notice: 'Deal item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @deal_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @deal_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/deal_items/1
  # PATCH/PUT /admin/deal_items/1.json
  def update
    respond_to do |format|
      if @deal_item.update(deal_item_params)
        format.html { redirect_to [:admin, @deal_item], notice: 'Deal item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @deal_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/deal_items/1
  # DELETE /admin/deal_items/1.json
  def destroy
    @deal_item.destroy
    respond_to do |format|
      format.html { redirect_to admin_deal_items_url, notice: 'Deal item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deal_item
      @deal_item = DealItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deal_item_params
      params.require(:deal_item).permit(:deal_id, :item_id)
    end
end
