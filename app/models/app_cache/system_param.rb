module AppCache
  class SystemParam < ActiveRecord::Base
    validates_presence_of :param_code
    after_save :auto_cache_update

    def auto_cache_update
      if AppCache.storage
        params = AppCache::SystemParam.all.to_json
        unless AppCache.cache_type == AppCache::CACHE_TYPE_REDIS
          AppCache.storage.del "system_params"
        end
        AppCache.storage.set("system_params", params)
      end
    end

    def self.cache_update
      params = AppCache::SystemParam.all.to_json
      unless AppCache.cache_type == AppCache::CACHE_TYPE_REDIS
        AppCache.storage.del "system_params"
      end
      AppCache.storage.set("system_params", params)
    end

    def self.get_cache
      params = JSON.load AppCache.storage.get "system_params"
      params
    end

    def self.get_params_cache
      json = self.get_cache
      h = {}
      json.each do |sp|
        h.store(sp['param_code'], sp['param_value'])
      end
      return h
    end

    def self.get_level_params_cache(level_id)
      json = self.get_cache
      h = {}
      json.each do |sp|
        if sp['param_level_id'].to_i == level_id
          h.store(sp['param_code'], sp['param_value'])
        end
      end
      return h
    end

    def self.get_params_db
      h = {}
      AppCache::SystemParam.all.each do |sp|
        h.store(sp.param_code, sp.param_value)
      end
      h
    end

    def self.get_level_params_db(level_id)
      h = {}
      AppCache::SystemParam.where(:param_level_id => level_id).each do |sp|
        h.store(sp.param_code, sp.param_value)
      end
      h
    end

    def self.get_params
      if AppCache.storage
        self.get_params_cache
      else
        self.get_params_db
      end
    end

    def self.get_level_params(level_id)
      if AppCache.storage
        self.get_level_params_cache(level_id)
      else
        self.get_level_params_db(level_id)
      end
    end

    def self.get_param_value(key)
      params = self.get_params
      param_val = params[key] || ''
      param_val
    end
  end
end
