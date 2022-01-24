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
      prepared_param = prepare_param(connection_params)

      ActiveRecord::Base.establish_connection(
        adapter:  DB_PROVIDER,
        encoding: ENCODING,
        port:     PORT,
        host:     prepared_param[:host],
        username: prepared_param[:user_name],
        password: prepared_param[:password],
        database: prepared_param[:database]
      )
    end

    private

    def prepare_param(env)
      { database:  env.store(value: "db_name"),
        password:  env.store(value: "db_password"),
        user_name: env.store(value: "db_user_name"),
        host:      env.store(value: "db_host") }
    end
  end

  class UsersModels < ActiveRecord::Base
    class << self
      def generate_token(params)
        "#{params[:chat_id]}_#{params[:first_name]}"
      end

      def generate_id
        user = Database::UsersModels.last
        user.id + 1
      end
    end
  end
end