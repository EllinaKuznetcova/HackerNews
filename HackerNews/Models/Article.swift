//
//  Article.swift
//  HackerNews
//
//  Created by Ellina Kuznetcova on 20/01/2017.
//  Copyright © 2017 Ellina Kuznetcova. All rights reserved.
//

import Foundation
import ObjectMapper

class Article {
    var id: Int = 0
    var title: String = ""
    var author: String = ""
    var publishedAt: Date = Date()
    var originalPost: URL?
    var score: Int = 0
    
    var commentsId: [Int] = []
    var comments: [Comment] = []
    
    init() {}
    
    required convenience init?(map: Map) {
        self.init()
    }
}

extension Article: Mappable {
    func mapping(map: Map) {
        self.id <- map["id"]
        self.title <- map["title"]
        self.author <- map["by"]
        self.score <- map["score"]
        self.commentsId <- map["kids"]
        
        if  let timeInterval = map.JSON["time"] as? Double {
            self.publishedAt = Date(timeIntervalSince1970: timeInterval)
        }
        
        if let urlString = map.JSON["url"] as? String {
            self.originalPost = URL(string: urlString)
        }
    }
}
