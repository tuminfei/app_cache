require 'fileutils'

namespace :app_cache do
  namespace :init do
    desc "Generate app_cache init file from example"
    task :create do
      source = File.join(Gem.loaded_specs["app_cache"].full_gem_path, "app_cache.rb")
      target = File.join(Rails.root, "config", "initializers", "app_cache.rb")
      FileUtils.cp_r source, target
    end

  end
end