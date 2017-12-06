//
//  CacheHelper.swift
//  RepoViewer
//
//  Created by Guillermo Zafra on 06/12/2017.
//  Copyright © 2017 Guillermo Zafra. All rights reserved.
//

import Foundation
import AwesomeCache

/// Simple Cache utility class to save data in a static cache
final class CacheHelper {
    fileprivate static let cacheName = "LocalCache"
    fileprivate static let cacheKey = "RepoList"
    fileprivate static let expirationSeconds: TimeInterval = 3600 * 24
    
    /// Returns the cached array of RepoDTO objects or nil if nothing is cached
    static func get() -> [RepoDTO]? {
        guard let cache = try? Cache<NSData>(name: cacheName),
            let data = cache[cacheKey] as Data? else { return nil }
        let decoded = try! JSONDecoder().decode([RepoDTO].self, from: data)
        return decoded
    }
    
    /// Caches the array of RepoDTO objects
    static func cache(_ value: [RepoDTO]) {
        guard let data = try? JSONEncoder().encode(value),
        let cache = try? Cache<NSData>(name: cacheName) else {
            print("Error saving cache")
            return
        }
        
        cache.setObject(data as NSData, forKey: cacheKey, expires: .seconds(expirationSeconds))
    }
    
    static func purge() {
        guard let cache = try? Cache<NSData>(name: cacheName) else { return }
        cache.removeAllObjects()
    }
}
