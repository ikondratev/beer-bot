module Services
  module Errors
    class BackendError < StandardError; end

    class LoadContainerError < BackendError; end

    class DBConnectionError < BackendError; end

    class AddUserActionError < BackendError; end
  end
end