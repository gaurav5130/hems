# Be sure to restart your server when you modify this file.

module ActionController
  module ParamsNormalizer
    extend ActiveSupport::Concern

    def process_action(*args)
      # pp "before action -------------"
      # pp request.parameters
      deep_underscore_params!(request.parameters)
      # pp "after action -------------"
      # pp request.parameters
      super
    end

    private
      def deep_underscore_params!(val)
        case val
        when Array
          val.map {|v| deep_underscore_params! v }
        when Hash
          val.keys.each do |k, v = val[k]|
            val.delete k
            val[k] = deep_underscore_params!(v)
          end
          val
        when String    
          res = val
          if (val)
            res = val.strip.upcase
          end

          res
        else
          val
        end
      end
  end
end

# This file contains settings for ActionController::ParamsWrapper which
# is enabled by default.

# Enable parameter wrapping for JSON. You can disable this by setting :format to an empty array.
ActiveSupport.on_load(:action_controller) do
  wrap_parameters format: [:json]
  include ::ActionController::ParamsNormalizer
end

# To enable root element in JSON for ActiveRecord objects.
# ActiveSupport.on_load(:active_record) do
#   self.include_root_in_json = true
# end
