# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application

# Settings of StackProf
is_stackprof         =  ENV['ENABLE_STACKPROF'].to_i.nonzero?
stackprof_mode       = (ENV['STACKPROF_MODE']       || :wall).to_sym
stackprof_interval   = (ENV['STACKPROF_INTERVAL']   || 1000).to_i
stackprof_save_every = (ENV['STACKPROF_SAVE_EVERY'] || 1).to_i
stackprof_path       =  ENV['STACKPROF_PATH']       || 'tmp/stackprof/'

use StackProf::Middleware, enabled:    is_stackprof,
                           mode:       stackprof_mode,
                           raw:        true,
                           interval:   stackprof_interval,
                           save_every: stackprof_save_every,
                           path:       stackprof_path
