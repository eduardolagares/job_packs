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

    def error(job, _exception)
      find_job_pack_item(job)
      @job_pack_item.status = JobPacks::JobPackItem::ERROR
      @job_pack_item.save!
    end

    def failure(job)
      find_job_pack_item(job)
      @job_pack_item.status = JobPacks::JobPackItem::ERROR
      @job_pack_item.save!
    end

    def after(job)
        find_job_pack_item job
        update_pack
    end

    private

    def find_job_pack_item(job)
      @job_pack_item ||= JobPacks::JobPackItem.where(job_id: job.id, job_type: job.class.to_s).first
    end

    def update_pack
      @job_pack_item.job_pack.refresh_status
    end
  end
end
