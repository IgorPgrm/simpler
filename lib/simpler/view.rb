require_relative 'render/render_html'
require_relative 'render/render_plain'
require 'erb'

module Simpler
  class View
    VIEW_BASE_PATH = 'app/views'.freeze

    def self.render(env)
      env['simpler.template'].is_a?(Hash) ? RenderPlain : RenderHtml
    end
  end
end
