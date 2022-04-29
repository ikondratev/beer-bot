module Services
  module Kernel
    module Lib
      def logger!
        Services::Log::BotLog.new.logger
      end

      def safe(category = self.class)
        yield
      rescue StandardError => e
        logger!.error("[#{category}]: #{e.message}")
        nil
      end
    end
  end
end
