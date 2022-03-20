require './services/log/bot_log'

module Services
  module Kernel
    module Lib
      def logger!
        Services::Log::BotLog.new.logger
      end

      def require_dir(path)
        dir = Dir.glob File.join(path,  '*.rb')
        dir.each { |file| require file }
      end

      def safe(category: self.class)
        yield
      rescue StandardError => e
        logger!.error("[#{category}]: #{e.message}")
        nil
      end
    end
  end
end
