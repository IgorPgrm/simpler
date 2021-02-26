require_relative 'view'

module Simpler
  class Controller
    attr_reader :name
    attr_accessor :params

    def initialize(env)
      @name = extract_name
      @request = Rack::Request.new(env)
      @response = Rack::Response.new
      @params = @request.params
    end

    def make_response(action)
      @request.env['simpler.controller'] = self
      @request.env['simpler.action'] = action
      @request.params.merge!(@request.env['simpler.params'])
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
      renderer = View.render(@request.env)
      renderer.new(@request.env).render(binding)
    end

    def render(template)
      @request.env['simpler.template'] = template
      set_header('Content-Type', 'text/plain') if template.is_a?(Hash)
    end
  end
end
