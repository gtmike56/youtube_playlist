//
//  CachManager.swift
//  youtube-playlist-app
//
//  Created by Mikhail Udotov on 11.05.2020.
//

import Foundation

class CacheManager {
    
    static var cache = [String:Data]()
    
    static func setVideoCache (url: String, data: Data?){
        cache[url] = data
    }
    
    static func getVideoCache (url:String) -> Data? {
        return cache[url]
    }
    
}
