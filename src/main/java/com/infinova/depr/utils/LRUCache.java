package com.infinova.depr.utils;

import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

public enum LRUCache {

	// 单例
	INSTANCE;
	// 默认缓存大小为10, 可更改
	private final int MAX_CACHE_SIZE = 10;
	// 默认负载因子0.75
	private final float DEFAULT_LOAD_FACTORY = 0.75f;
	// 缓存使用LinkedHashMap实现
	private LinkedHashMap<String, Object> map;

	private LRUCache() {
		int capacity = (int) Math.ceil(MAX_CACHE_SIZE / DEFAULT_LOAD_FACTORY) + 1;
		map = new LinkedHashMap<String, Object>(capacity, DEFAULT_LOAD_FACTORY, true) {
			private static final long serialVersionUID = -2140116028308181875L;

			@Override
			protected boolean removeEldestEntry(Map.Entry<String, Object> eldest) {
				return size() > MAX_CACHE_SIZE;
			}
		};
	}

	public synchronized void put(String key, Object value) {
		map.put(key, value);
	}

	public Object get(String key) {
		return map.get(key);
	}

	public synchronized void remove(String key) {
		map.remove(key);
	}

	public Set<Map.Entry<String, Object>> getAll() {
		return map.entrySet();
	}

}
