$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

if Rails::VERSION::MAJOR > 2
  module Cheaptoad
    class Cheaptoad < Rails::Engine
    end
  end
end
