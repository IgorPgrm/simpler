# frozen_string_literal: true

require_relative 'simpler/application'

module Simpler
  class << self
    def application
      Application.instance
    end
  end
end
