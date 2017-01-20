//
//  ArticlesReducer.swift
//  HackerNews
//
//  Created by Ellina Kuznetcova on 20/01/2017.
//  Copyright © 2017 Ellina Kuznetcova. All rights reserved.
//

import Foundation

func topStoriesReducer (state: [Article]?, action: Action) -> [Article] {
    switch action {
    case let action as SetArticles:
        return action.articles
    default:
        return []
    }
}
