# coding: utf-8
module Apress
  module Sources
    class CachedSource < Base
      DEFAULT_CACHE_EXPIRES_IN = 1.hours

      class << self
        def reset_cache!
          Rails.cache.delete_by_tags([cache_tag])
        end

        def data
          if cache_configured?
            Rails.cache.fetch(cache_key, cache_options) { init_data }
          else
            init_data
          end
        end

        private

        def init_data
          raise 'not implemented'
        end

        def cache_key
          "source:#{Digest::MD5.hexdigest(cache_tag)}"
        end

        def cache_expires_in
          DEFAULT_CACHE_EXPIRES_IN
        end

        def cache_tag
          self.name.underscore.tr('/', '_')
        end

        def cache_options
          {expires_in: cache_expires_in, tags: [cache_tag]}
        end

        def cache_configured?
          config = Rails.application.config
          config.respond_to?(:perform_caching_queries) && config.perform_caching_queries
        end
      end
    end
  end
end
