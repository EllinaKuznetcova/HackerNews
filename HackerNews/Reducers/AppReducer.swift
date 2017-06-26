//
//  AppReducer.swift
//  HackerNews
//
//  Created by Ellina Kuznetcova on 09/01/2017.
//  Copyright © 2017 Ellina Kuznetcova. All rights reserved.
//

struct AppReducer: Reducer {
    
    func handleAction(action: Action, state: AppState?) -> AppState {
        return AppState(
            navigationState: NavigationReducer.handleAction(action, state: state?.navigationState),
            articles: topStoriesReducer(state: state?.articles, action: action),
            articlesListCount: 10
        )
    }
    
}
