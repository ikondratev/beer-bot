require 'singleton'
require 'active_record'
require 'pg'
require "base64"

module Db
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
    rescue StandardError => e
      raise Services::Errors::DBConnectionError.new(e.message)
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
        Base64.encode64("#{params[:chat_id]}_#{params[:first_name]}").gsub!(/[^0-9A-Za-z]/, '')
      end

      def generate_id
        user = Db::UsersModels.last
        user.id + 1
      end

      def to_base_64(user)
        Base64.encode64("#{user.token}_#{user.email}_#{user.name}")
      end

      def not_unique_user?(user)
        users = Db::UsersModels.all

        users.any? do |base_user|
          self.to_base_64(base_user) ==  self.to_base_64(user)
        end
      end
    end
  end
end