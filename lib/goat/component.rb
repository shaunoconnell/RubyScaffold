
module Goat
  class Component
    def initialize
      
    end

    def pre_setup
      puts "pre setup"
    end

    def setup
      puts "setup"
    end

    def build
      puts "build"
    end

    def finalize
      puts "finalize"
    end

    def cleanup
      puts "cleanup"
    end
  end

  
end
