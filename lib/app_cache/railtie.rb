#encoding: utf-8
module AppCache
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'rake/app_cache.rake'
    end
  end
end
