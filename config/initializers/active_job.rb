
Rails.application.config.active_job.queue_adapter = :delayed_job
Delayed::Job.destroy_all
ArpWatchJob.perform_later

at_exit do
  Delayed::Job.destroy_all
end