module JobPacks
  class JobPackItem < ::ActiveRecord::Base
    belongs_to :job_pack
    belongs_to :job, polymorphic: true

    WAITING = 0
    RUNNING = 1
    ERROR = 2
    DONE = 3

    scope :done, -> {
      where(status: DONE)
    }

    scope :running, -> {
      where(status: RUNNING)
    }

    scope :error, -> {
      where(status: ERROR)
    }

    scope :waiting, -> {
      where(status: WAITING)
    }

    attr_accessor :delayed_job

    before_create :run_job_and_set_status
    after_commit :update_pack

    def refresh_job_status
      self.status = if job
                      if !job.locked_at.nil?
                        RUNNING
                      elsif !job.last_error.nil?
                        ERROR
                      else
                        WAITING
                      end
                    else
                      DONE
                    end

      save! if changed?
    end

    private

    def update_pack
      job_pack.update_progress
    end

    def run_job_and_set_status
      self.job = Delayed::Job.enqueue delayed_job
      self.status = WAITING
    end
  end
end
