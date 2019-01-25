class StoreItem < ApplicationRecord
  belongs_to :store, counter_cache: true
  belongs_to :item
  validates_uniqueness_of :item_id, scope: :store_id

  def mark_as_out_of_stock
  		update(out_of_stock: true)
  end
end
