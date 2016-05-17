# coding: utf-8
require 'rails/engine'

module Apress
  module Sources
    class Engine < ::Rails::Engine
      config.autoload_paths += Dir["#{config.root}/lib"]
    end
  end
end
