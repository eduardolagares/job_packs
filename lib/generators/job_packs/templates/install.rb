class <%= migration_class_name %> < <%= migration_parent %>
  def self.up
    create_table :job_packs, force: true do |t|
      t.column :description, :text
      t.column :total_items_done, :integer
      t.column :total_items_with_error, :integer, default: 0
      t.column :total_items_waiting, :integer, default: 0
      t.column :total_items_running, :integer, default: 0
      t.column :done, :boolean, default: :false
      t.timestamps
    end

    create_table :job_pack_items, force: true do |t|
      t.references :job_pack
      t.column :description, :text
      t.column :job_id, :integer
      t.column :job_type, :string
      t.column :status, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :job_packs
    drop_table :job_pack_items
  end
end