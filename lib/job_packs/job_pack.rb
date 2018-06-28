module JobPacks
  class JobPack < ::ActiveRecord::Base
    has_many :job_pack_items

    def add_item(item)
      job_pack_items << item
    end

    def update_progress(force_item_refresh = false )
      job_pack_items.each(&:refresh_job_status) if force_item_refresh
      self.total_items_with_error = job_pack_items.error.count
      self.total_items_waiting = job_pack_items.waiting.count
      self.total_items_running = job_pack_items.running.count
      self.total_items_done = job_pack_items.done.count
      self.done = total_items_done == total_items
      save!
    end

    def progress
      ((total_items_done.to_f * 100) / total_items.to_f).to_f
    end

    def total_items
      job_pack_items.count.to_i
    end
  end
end
