# frozen_string_literal: true

Rails.application.configure do
  config.good_job.execution_mode = :async_server
  config.good_job.queues = '*'
  config.good_job.enable_cron = true
  config.good_job.cron = {
    refresh_current_prices: {
      cron: '*/5 * * * *',
      queues: '*',
      set: { priority: 10 },
      class: 'RefreshCurrentPricesJob',
      enabled_by_default: true,
      description: 'Refresh the latest bitcoin price'
    },
    refresh_usd_historical_prices: {
      cron: '0 * * * *',
      queues: '*',
      set: { priority: 5 },
      args: ['USD'],
      class: 'RefreshHistoricalPricesJob',
      enabled_by_default: true,
      description: 'Refresh the historical USD bitcoin prices'
    },
    refresh_cad_historical_prices: {
      cron: '5 * * * *',
      queues: '*',
      set: { priority: 5 },
      args: ['CAD'],
      class: 'RefreshHistoricalPricesJob',
      enabled_by_default: true,
      description: 'Refresh the historical CAD bitcoin prices'
    }
  }
end

Rails.application.config.after_initialize do
  RefreshCurrentPricesJob.perform_later
end
