//
//  Routes.swift
//  HackerNews
//
//  Created by Ellina Kuznetcova on 09/01/2017.
//  Copyright © 2017 Ellina Kuznetcova. All rights reserved.
//

import Foundation

enum AppRoutes: RouteElementIdentifier {
    case mainView = "Main"
}

let storyboard = UIStoryboard(name: "Main", bundle: nil)

class RootRoutable: Routable {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        guard let route = AppRoutes(rawValue: routeElementIdentifier) else { fatalError("Cannot find route") }
        switch route {
        case .mainView:
            self.window.rootViewController = storyboard.instantiateViewController(withIdentifier: route.rawValue)
            completionHandler()
            return NewsListRoutable(self.window.rootViewController!)
        }
    }
    
    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
        completionHandler()
    }
    
    func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        guard let route = AppRoutes(rawValue: from) else { fatalError("Cannot find route") }
        self.window.rootViewController = storyboard.instantiateViewController(withIdentifier: route.rawValue)
        completionHandler()
        return NewsListRoutable(self.window.rootViewController!)
    }
}

class NewsListRoutable: Routable {
    let viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func pushRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        guard let route = AppRoutes(rawValue: routeElementIdentifier) else { fatalError("Cannot find route") }
        switch route {
        case .mainView:
            let detailViewController = storyboard.instantiateViewController(withIdentifier: route.rawValue)
            return NewsListRoutable(detailViewController)
        }
    }
    
    func popRouteSegment(_ routeElementIdentifier: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) {
        
    }
    
    func changeRouteSegment(_ from: RouteElementIdentifier, to: RouteElementIdentifier, animated: Bool, completionHandler: @escaping RoutingCompletionHandler) -> Routable {
        guard let route = AppRoutes(rawValue: from) else { fatalError("Cannot find route") }
        let detailViewController = storyboard.instantiateViewController(withIdentifier: route.rawValue)
        return NewsListRoutable(detailViewController)
    }
}

