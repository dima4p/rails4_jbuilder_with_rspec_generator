require 'rails/generators/named_base'
require 'rails/generators/resource_helpers'

module Rails
  module Generators
    class JbuilderGenerator < NamedBase
      include Rails::Generators::ResourceHelpers

      source_root File.expand_path('../templates', __FILE__)

      argument :attributes, type: :array, default: [], banner: 'field:type field:type'

      def create_root_folder
        path = File.join('app/views', controller_file_path)
        empty_directory path unless File.directory?(path)
      end

      def copy_view_files
        %w(index show).each do |view|
          filename = filename_with_extensions(view)
          template filename, File.join('app', 'views', controller_file_path, filename)
        end
      end

      def copy_spec_files
        copy_spec_file :index #unless options[:singleton]
        copy_spec_file :show
      end

      protected
 
      def filename_with_extensions(name)
        [name, :json, :jbuilder] * '.'
      end

      def attributes_list_with_timestamps
        attributes_list(attributes_names + %w(created_at updated_at))
      end

      def attributes_list(attributes = attributes_names)
        if self.attributes.any? {|attr| attr.name == 'password' && attr.type == :digest}
          attributes = attributes.reject {|name| %w(password password_confirmation).include? name}
        end

        attributes.map { |a| ":#{a}"} * ', '
      end

      def copy_spec_file(view)
        template "#{view}_spec.rb", File.join("spec", "views", controller_file_path, "#{view}.json.jbuilder_spec.rb")
      end

      # support for namespaced-resources
      def ns_file_name
        ns_parts.empty? ? file_name : "#{ns_parts[0].underscore}_#{ns_parts[1].singularize.underscore}"
      end

      # support for namespaced-resources
      def ns_table_name
        ns_parts.empty? ? table_name : "#{ns_parts[0].underscore}/#{ns_parts[1].tableize}"
      end

      def ns_parts
        @ns_parts ||= begin
                        matches = ARGV[0].to_s.match(/\A(\w+)(?:\/|::)(\w+)/)
                        matches ? [matches[1], matches[2]] : []
                      end
      end

    end
  end
end
