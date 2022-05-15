class CacheManager<T> {
  final Map<String, T> _cache = {};

  T? get(String key) => _cache[key];

  void set(String key, T cachedData) => _cache[key] = cachedData;

  bool contains(String key) => _cache.containsKey(key);

  void remove(String key) => _cache.remove(key);
}
