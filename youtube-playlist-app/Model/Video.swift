//
//  Video.swift
//  youtube-playlist-app
//
//  Created by Mikhail Udotov on 11.05.2020.
//

import Foundation

struct Video : Decodable{
    
    var video_id = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published : Date
    
    enum CodingKeys: String, CodingKey {
        
        case snippet
        case high
        case thumbnails
        case resourceId
        
        case published = "publishedAt"
        case title
        case description
        case thumbnail = "url"
        case video_id = "videoId"
        
    }
    
    init(from decoder: Decoder) throws {
        let constainer = try decoder.container(keyedBy: CodingKeys.self)
        let snippet_container = try constainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
        self.title = try snippet_container.decode(String.self, forKey: .title)
        self.description = try snippet_container.decode(String.self, forKey: .description)
        self.published = try snippet_container.decode(Date.self, forKey: .published)
        
        let thumbnailContainer =  try snippet_container.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        
        let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
        
        self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        
        let resourseIdContainer = try snippet_container.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        
        self.video_id = try resourseIdContainer.decode(String.self, forKey: .video_id)
    }
    
}
