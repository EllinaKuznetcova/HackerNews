//
//  AppState.swift
//  HackerNews
//
//  Created by Ellina Kuznetcova on 09/01/2017.
//  Copyright © 2017 Ellina Kuznetcova. All rights reserved.
//

import Foundation

struct AppState: StateType, HasNavigationState {
    var navigationState: NavigationState
    var articles: [Article]
    
    var articlesListCount: Int
}
