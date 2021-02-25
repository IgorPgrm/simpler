# frozen_string_literal: true

module Simpler
  class Router
    class Route
      attr_reader :controller, :action, :params

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @params = {}
      end

      def match?(method, path)
        @request_path_elements = path.split('/').reject!(&:empty?)
        if @request_path_elements.count == 1
          match_without_params?(method, path)
        else
          match_with_params?
        end
      end

      def match_without_params?(method, path)
        @method == method && @path.match(path)
      end

      def match_with_params?
        @route_path_elements = @path.split('/').reject!(&:empty?)
        if @route_path_elements.count == @request_path_elements.count &&
           (@route_path_elements[0] == @request_path_elements[0])
          add_params_to_controller
          true
        end
      end

      def add_params_to_controller
        @params = { id: @request_path_elements[1].to_i }
        @request_path_elements[1] = @route_path_elements[1]
      end

    end
  end
end
