module Apress
  module Sources
    # Модуль добавляет классу метод extract_object, подходит для источников и полей денормализации.
    #
    # Example:
    #
    #   class Field
    #     extend Apress::Sources::ExtractObject
    #     extract_attribute_name :user
    #   end
    #
    #   Field.extract_object(object: {user_id: 1})
    #     => 1
    module ExtractObject
      def extract_attribute_name(name)
        class_attribute :attribute_name, instance_writer: false
        singleton_class.send(:alias_method, "extract_#{name}".to_sym, :extract_object)

        self.attribute_name = name
      end

      def extract_object(params)
        Apress::Sources::ObjectIdExtractor.new(attribute_name.to_sym).call(params)
      end
    end
  end
end
