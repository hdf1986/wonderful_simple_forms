require 'simple_form'
require 'pry'
module WonderfulSimpleForms
  module SimpleForm
     module BuilderExtension
      def default_input_type_with_enum(*args, &block)
        att_name = (args.first || @attribute_name).to_s
        options = args.last
        return :enum if (options.is_a?(Hash) ? options[:as] : @options[:as]).nil? &&
                        is_enum_attributes?( att_name )

        default_input_type_without_enum(*args, &block)
      end

      def default_input_type_with_belongs_to(*args, &block)
        att_name = (args.first || @attribute_name).to_s
        options = args.last
        return :belongs_to if (
          object.class.reflect_on_all_associations(:belongs_to).any? { |a| a.name == args.first })

        default_input_type_without_belongs_to(*args, &block)
      end

      def is_enum_attributes?( attribute_name )
        object.class.respond_to?(:defined_enums) &&
          object.class.defined_enums.key?(attribute_name) &&
          attribute_name.pluralize != "references"
      end
    end

    class EnumInput < ::SimpleForm::Inputs::CollectionSelectInput
      def collection
        @collection ||= enum_list
      end

      def enum_list
        object.class.method(attribute_name.to_s.pluralize.to_sym).call
      end
    end

    class BelongsToInput < ::SimpleForm::Inputs::CollectionSelectInput
      def collection
        @collection ||= enum_list
      end

      def enum_list
        attribute_name.to_s.classify.constantize.all.map{|instance|[instance.method(:name).call, instance.id]}
      end
    end
  end
end

SimpleForm::FormBuilder.class_eval do
  include WonderfulSimpleForms::SimpleForm::BuilderExtension
  map_type :enum,               :to => WonderfulSimpleForms::SimpleForm::EnumInput
  map_type :belongs_to,               :to => WonderfulSimpleForms::SimpleForm::BelongsToInput

  alias_method_chain :default_input_type, :enum
  alias_method_chain :default_input_type, :belongs_to
end