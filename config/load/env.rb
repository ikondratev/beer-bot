module Config
  module Load
    class Env
      def initialize(mode: :test)
        path = Constants::MODES[mode.to_sym]
        Figaro.application = Figaro::Application.new(environment: mode, path: path)
        Figaro.load
      end

      def store(value:)
        Figaro.env.send(value)
      end
    end
  end
end
