# Null Presenter class for default data representation

module HexagonalJsonApi
  module Presenters
    class NullPresenter < Base

      def data_hash
        {}
      end

    end
  end
end
