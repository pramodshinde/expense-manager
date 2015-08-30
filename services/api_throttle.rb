class ApiThrottle
  EXPIRES_IN = 10.minutes

  class << self
    def client
      redis = Redis.new
    end

    def api_limit?(key, limit = 0)
      self.increment(key) > limit
    end

    def increment(key)
      limit = client.incr(key.to_s)
      client.expire(key, EXPIRES_IN) if limit == 1
      limit
    end
  end
end