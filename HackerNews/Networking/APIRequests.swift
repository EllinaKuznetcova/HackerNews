//
//  APIRequests.swift
//  HackerNews
//
//  Created by Ellina Kuznetcova on 20/01/2017.
//  Copyright © 2017 Ellina Kuznetcova. All rights reserved.
//

import Foundation
import ObjectMapper

func fetchTopStories(state: AppState, store: Store<AppState>) -> Action? {
    func getStory(id: Int) {
        
    }
    let _ = NetworkRouter.getTopStoriesId.request().responseObject { (response: DataResponse<NRStoriesIds>) in
        switch response.result {
        case .success(let value):
            let storiesIdsToReceive = value.storiesIds.count < state.articlesListCount ?
                value.storiesIds :
                Array(value.storiesIds[0...state.articlesListCount])
            
            var stories = [Article]()
            var failedStories = 0
            storiesIdsToReceive.forEach({
                let _ = NetworkRouter.getStory(id: $0).request().responseObject({ (response: DataResponse<NRStory>) in
                    switch response.result {
                    case .success(let value):
                        stories.append(value.story)
                    case .failure(let error):
                        print(error)
                        failedStories += 1
                    }
                    
                    if failedStories + stories.count == storiesIdsToReceive.count {
                        DispatchQueue.main.async {
                            store.dispatch(SetArticles(articles: stories))
                        }
                    }
                })
            })
            return
        case .failure(let error):
            print(error)
        }
    }
    return nil
}

struct NRStoriesIds: Mappable {
    var storiesIds: [Int]
    
    init?(map: Map) {
        self.storiesIds = []
    }
    
    mutating func mapping(map: Map) {
        self.storiesIds <- map["value"]
    }
}

struct NRStory: Mappable {
    var story: Article
    
    init?(map: Map) {
        self.story = Article()
    }
    
    mutating func mapping(map: Map) {
        self.story <- map["value"]
    }
}
