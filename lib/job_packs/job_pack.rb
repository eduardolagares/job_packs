module JobPacks
  class JobPack < ::ActiveRecord::Base
    has_many :job_pack_items

    def add_item(item)
      job_pack_items << item
    end

    def refresh_status
      job_pack_items.each(&:refresh_job_status)

      self.total_items_done = job_pack_items.done.count
      self.total_items_with_error = job_pack_items.error.count
      self.total_items_waiting = job_pack_items.waiting.count
      self.total_items_running = job_pack_items.running.count

      save! if changed?
    end

    def progress
      ((total_items_done.to_f * 100) / job_pack_items.count.to_f).to_f
    end
  end
end
