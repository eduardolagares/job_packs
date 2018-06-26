module JobPacks
  module Callbacks
    def success(job)
      find_job_pack_item(job)
      @job_pack_item.status = JobPacks::JobPackItem::DONE
      @job_pack_item.save!
    end

    def before(job)
      find_job_pack_item(job)
      @job_pack_item.status = JobPacks::JobPackItem::RUNNING
      @job_pack_item.save!
    end

    def failure(job)
      find_job_pack_item(job)
      @job_pack_item.status = JobPacks::JobPackItem::ERROR
      @job_pack_item.save!
    end

    private

    def find_job_pack_item(job)
      @job_pack_item = JobPacks::JobPackItem.where(job_id: job.id, job_type: job.class.to_s).first
    end
  end
end
