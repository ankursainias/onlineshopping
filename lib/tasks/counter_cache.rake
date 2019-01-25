desc 'Counter cache for project has many tasks'

task task_counter: :environment do
  Store.reset_column_information
  Store.pluck(:id).each  do |id|
    Store.reset_counters id, :store_items
  end
end