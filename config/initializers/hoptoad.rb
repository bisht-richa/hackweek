HoptoadNotifier.configure do |config|
  # Change this to some sensible data for your errbit instance
  config.api_key = Rails.application.secrets.errbit_api_key || ""
  config.host    = ENV["HACKWEEK_ERRBIT_HOST"] || ""
  if config.api_key.blank? || config.host.blank?
    config.development_environments = "production development test"
  else
    config.development_environments = "development test"
  end

  config.ignore_only = %w{
    ActiveRecord::RecordNotFound
  }

  config.ignore_by_filter do |exception_data|
    ret=false
    if exception_data[:error_class] == "ActionController::RoutingError" 
      message = exception_data[:error_message]
      ret=true if message =~ %r{\[GET\]}
    end
    ret
  end

end
