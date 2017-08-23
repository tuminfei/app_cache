module AppCache
  class SystemParam < ActiveRecord::Base
    validates_presence_of :param_code
    #after_save :app_cache

    def app_cache
      params = AppCache::SystemParam.all.to_json
      AppCache.storage.del "system_params"
      AppCache.storage.set("system_params", params)
    end
  end
end