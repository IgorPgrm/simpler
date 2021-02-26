module Simpler
  class View
    class RenderPlain

      def initialize(env)
        @env = env
      end

      def render(_)
        @env['simpler.template'][:plain]
      end
    end
  end
end
