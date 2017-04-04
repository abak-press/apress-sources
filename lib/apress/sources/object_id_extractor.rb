module Apress
  module Sources
    # Extract id from params where exists object key
    #
    # @example:
    #   Apress::Sources::ObjectIdExtractor.new(:user).call(object: {user_id: 1})
    #   => 1
    #
    # @api public
    #
    # @since 0.2.0
    class ObjectIdExtractor
      attr_reader :object_name

      # Create new extractor
      #
      # @param [Symbol] object_name (:user, :company)
      #
      # @return [Apress::Sources::ObjectIdExtractor]
      def initialize(object_name)
        @object_name = object_name
      end

      # @param [Hash] params
      # @option params [String, Numeric, Proc, Object, Hash] :object
      #
      # @example String
      #   ObjectIdExtractor.new(:user).call(object: '1')
      #
      # @example Hash
      #   ObjectIdExtractor.new(:user).call(object: {user: 1})
      #   ObjectIdExtractor.new(:user).call(object: {user_id: User.new})
      #   ObjectIdExtractor.new(:user).call(object: {user_id: ->{ 1 }})
      #
      # @return [Integer]
      #
      # @raise ArgumentError if can`t extract id from params
      def call(params = {})
        object = params.fetch(:object)
        object = object[object_name] || object["#{object_name}_id".to_sym] if object.is_a?(Hash)

        case object
        when Numeric
          object
        when String
          object.to_i
        else
          if object && object.respond_to?(:id)
            object.id
          elsif object.respond_to?(:call)
            object.call
          else
            raise ArgumentError.new(
              "#{object_name} instance or Numeric/String/Proc #{object_name} id expected!', #{params.inspect}"
            )
          end
        end
      end
    end
  end
end
