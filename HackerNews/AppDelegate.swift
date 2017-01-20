//
//  AppDelegate.swift
//  HackerNews
//
//  Created by Ellina Kuznetcova on 06/01/2017.
//  Copyright © 2017 Ellina Kuznetcova. All rights reserved.
//

import UIKit

var store = Store<AppState>(reducer: AppReducer(), state: nil)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var router: Router<AppState>!


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        /*
         Set a dummy VC to satisfy UIKit
         Router will set correct VC throug async call which means
         window would not have rootVC at completion of this method
         which causes a crash.
         */
        window?.rootViewController = UIViewController()
        
        let rootRoutable = RootRoutable(window: window!)
        
        router = Router(store: store, rootRoutable: rootRoutable) { state in
            return state.navigationState
        }
        
        store.dispatch(ReSwiftRouter.SetRouteAction([AppRoutes.mainView.rawValue]))

        return true
    }

}

