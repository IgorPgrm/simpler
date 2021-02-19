require_relative 'view'

module Simpler
  class Controller
    attr_reader :name

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action
      set_default_headers
      send(action)
      write_response
      @response.finish
    end

    private

    def extract_name
      self.class.name.match('(?<name>.+)Controller')[:name].downcase
    end

    def set_default_headers
      @response['Content-Type'] = 'text/html'
    end

    def set_header(header, value)
      @response[header] = value
    end

    def status(code)
      @response.status = code
    end

    def write_response
      body = render_body
      @response.write(body)
    end

    def render_body
      View.new(@request.env).render(binding)
    end

    def render(template)
      if template.is_a?(Hash)
        render_plain_text(template[:plain])
      else
        @request.env['simpler.template'] = template
      end
    end

    def render_plain_text(text)
      set_header('Content-Type', 'text/plain')
      @request.env['text'] = text
    end
  end
end
