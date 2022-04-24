module Db
  class Connection
    include Singleton

    def adapter(env:)
      prepared_param = prepare_param(env)

      ActiveRecord::Base.establish_connection(
        adapter: prepared_param[:adapter],
        encoding: prepared_param[:encoding],
        port: prepared_param[:port],
        host: prepared_param[:host],
        username: prepared_param[:user_name],
        password: prepared_param[:password],
        database: prepared_param[:database]
      )
    end

    private

    def prepare_param(env)
      { database: env.store(value: "database"),
        password: env.store(value: "password"),
        user_name: env.store(value: "username"),
        host: env.store(value: "host"),
        adapter: env.store(value: "adapter"),
        encoding: env.store(value: "encoding"),
        port: env.store(value: "port") }
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
          to_base_64(base_user) == to_base_64(user)
        end
      end
    end
  end
end
