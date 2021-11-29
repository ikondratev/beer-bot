require 'singleton'
require 'active_record'

module Database
  class Connection
    include Singleton
    DB_PROVIDER = "mysql2".freeze

    def initialize(connection_params:)
      @adapter = ActiveRecord::Base.establish_connection(
        adapter: DB_PROVIDER,
        host:     connection_params[:host],
        username: connection_params[:username],
        password: connection_params[:password],
        database: connection_params[:database]
      )
    end

    def adapter
      @adapter
    end
  end
end