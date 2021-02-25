# frozen_string_literal: true

require_relative 'config/environment'
require_relative 'lib/simpler/simpler_logger'

use Simpler::SimplerLogger, log_path: 'app/log/app.log'
run Simpler.application
