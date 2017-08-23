class CreateAppCacheSystemParams < ActiveRecord::Migration
  def self.up
    create_table :app_cache_system_params do |t|
      t.string :param_code, :limit =>50
      t.string :param_name
      t.string :param_value, :limit =>100
      t.string :param_desc
      t.string :param_level, :limit =>50
      t.integer :param_level_id
      t.string :status, :limit =>20
      t.integer :created_by
      t.integer :updated_by
      t.integer :lock_version
      t.timestamps
    end
  end

  def self.down
    drop_table :app_cache_system_params
  end
end