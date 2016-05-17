# coding: utf-8
module Apress
  module Sources
    module Accessors
      def value_as_string(params)
        raise_no_accessor(:string, params)
      end

      def value_as_integer(params)
        raise_no_accessor(:integer, params)
      end

      def value_as_boolean(params)
        raise_no_accessor(:boolean, params)
      end

      def value_as_date(params)
        raise_no_accessor(:date, params)
      end

      def value_as_array(params)
        raise_no_accessor(:array, params)
      end

      private

      def raise_no_accessor(accessor_type, params)
        raise Apress::Sources::Errors::NoAccessor.new(self, accessor_type, params)
      end
    end
  end
end
