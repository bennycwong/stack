class AddQuerySizeToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :query_size, :integer
  end
end
