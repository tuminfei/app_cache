require 'app_cache/version'
require 'app_cache/engine'
require 'app_cache/local_file_cache'
require "app_cache/railtie" if defined?(Rails)

module AppCache
  CACHE_TYPE_REDIS = 'redis'
  CACHE_TYPE_FILE = 'file'

  class << self
    attr_accessor :storage

    def new(cache_type, options = {})
      case cache_type
        when CACHE_TYPE_REDIS
          @storage = Redis.new(:url => options[:url])
        else
          @storage = AppCache::LocalFileCache.new(options[:file_path])
      end
      #更新缓存
      AppCache::SystemParam.cache_update
    end

    def sys_params_cache
      h_params = AppCache::SystemParam.get_params_cache
      h_params
    end

    def sys_params_db
      h_params = AppCache::SystemParam.get_params_db
      h_params
    end

    def get_params
      vals = AppCache::SystemParam.get_params
      vals
    end

    def get_level_params(level_id)
      vals = AppCache::SystemParam.get_level_params(level_id)
      vals
    end

    def get_param_value(key)
      val = AppCache::SystemParam.get_param_value(key)
      val
    end
  end
end
