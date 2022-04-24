module Services
  module Log
    class BotLog
      attr_accessor :logger

      def initialize(std_out: $stdout)
        @logger = Logger.new(std_out)
      end
    end
  end
end
