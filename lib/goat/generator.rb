
module Goat
  class Generator
    def initialize(components)
      return if components.nil?

      if components.is_a? Enumerable
        @components = components
      else
        @components = [components]
      end
    end

    LIFE_CYCLE_METHODS = ['pre_setup','setup','build','finalize','cleanup']

    def run
      LIFE_CYCLE_METHODS.each do |method_name|
        @components.each_entry do | component |
          component.send(method_name)
        end
      end
    end
  end
end
