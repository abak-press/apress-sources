# coding: utf-8
module Apress
  module Sources
    module Errors
      class SourceError < StandardError; end

      class NoAccessor < SourceError
        def initialize(klass, accessor_type, params)
          super "Класс #{klass} не реализует доступ к полю как к #{accessor_type}, #{params.inspect}"
        end
      end
    end
  end
end
