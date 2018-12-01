# frozen_string_literal: true

require 'rails'

module Html5Validators
  @enabled = true

  class << self
    attr_accessor :enabled
  end

  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'html5_validators' do
      config.after_initialize do
        require 'html5_validators/active_model/helper_methods'
        require 'html5_validators/active_model/validations'
      end

      ActiveSupport.on_load(:active_record) do
        require 'html5_validators/active_record/base'
      end

      ActiveSupport.on_load(:action_view) do
        if ActionPack::VERSION::STRING >= '4'
          require 'html5_validators/action_view/form_helpers'
        else
          require 'html5_validators/action_view/form_helpers_rails3'
        end
      end
    end
  end
end
