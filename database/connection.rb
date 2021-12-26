require 'singleton'
require 'active_record'
require 'pg'

module Database
  class Connection
    include Singleton
    DB_PROVIDER = "postgresql".freeze
    ENCODING = "unicode".freeze
    PORT = 9490

    def adapter(connection_params:)
      ActiveRecord::Base.establish_connection(
        adapter:  DB_PROVIDER,
        encoding: ENCODING,
        port:     PORT,
        host:     connection_params[:host],
        username: connection_params[:user_name],
        password: connection_params[:password],
        database: connection_params[:database]
      )
    end
  end

  class UsersModels < ActiveRecord::Base
  end
end