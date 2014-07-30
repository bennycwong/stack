class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :query
      t.string :query_type

      t.timestamps
    end
  end
end
