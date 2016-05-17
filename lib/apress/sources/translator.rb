# coding: utf-8
module Apress
  module Sources
    class Translator < Base
      class << self
        def value_as_string(params)
          translated_value(params).to_s
        end

        def value_as_integer(params)
          translated_value(params).to_i
        end

        def value_as_boolean(params)
          translated_value(params).to_s.mb_chars.downcase.to_b
        end

        def value_as_date(params)
          translated_value(params).to_s.to_date
        end

        private

        def translated_value(params)
          field = params.fetch(:field)
          params.fetch(:object).fetch(field)
        end
      end
    end
  end
end
