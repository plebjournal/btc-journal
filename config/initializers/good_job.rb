# frozen_string_literal: true

Rails.application.configure do
  config.good_job.execution_mode = :async_server
  config.good_job.queues = '*'
  config.good_job.enable_cron = true
  config.good_job.cron = {
    refresh_prices: {
      cron: "*/5 * * * *",
      queues: '*',
      set: { priority: 10 },
      class: "RefreshCurrentPricesJob",
      enabled_by_default: true,
      description: "Refresh the bitcoin prices",
    },
  }
end

Rails.application.config.after_initialize do
  RefreshCurrentPricesJob.perform_later
end