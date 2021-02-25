require 'logger'

module Simpler
  class SimplerLogger
    def initialize(app, **options)
      @logger = Logger.new(options[:log_path] || $stdout)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)
      @logger.info(log_format(env, headers, status))
      [status, headers, response]
    end

    def log_format(env, headers, status)
      "
      Request: #{env['REQUEST_METHOD']} #{env['REQUEST_URI']}\n
      Handler: #{env['simpler.controller'].class.name}##{env['simpler.action']}\n
      Parameters: #{env['QUERY_STRING']}\n
      Response: #{status} [#{headers['Content-Type']}] #{env['simpler.template_path']}\n
      "
    end
  end
end
