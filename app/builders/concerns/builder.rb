module Concerns
  module Builder
    def self.[](klass)
      Module.new do
        mattr_accessor :klass
        self.klass = klass

        def self.included(mod)
          mod.include ::Concerns::Buildable
          mod.builder_class = klass
        end
      end
    end
  end
end
