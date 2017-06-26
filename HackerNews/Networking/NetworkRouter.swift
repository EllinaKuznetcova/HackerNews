//
//  NetworkRoute.swift
//  HackerNews
//
//  Created by Ellina Kuznetcova on 20/01/2017.
//  Copyright © 2017 Ellina Kuznetcova. All rights reserved.
//

import Foundation

enum NetworkRouter: NetworkRouterProtocol {
    static let BaseURL = "https://hacker-news.firebaseio.com/v0"
    
    case getTopStoriesId
    case getStory(id: Int)
    
    static let manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        
        var headers: [AnyHashable: Any] = [:]
        for header in SessionManager.defaultHTTPHeaders {
            headers.updateValue(header.1, forKey: header.0)
        }
        configuration.httpAdditionalHeaders = headers
        
        let manager = SessionManager(configuration: configuration)
        return manager
    }()
    
    func request (baseUrl: String = NetworkRouter.BaseURL) -> DataRequest {
        let path = "\(baseUrl)\(self.path)"
        
        
        let request = NetworkRouter.manager.request(path, method: self.settings.method, parameters: self.parameters, encoding: self.settings.encoding, headers: [:]).validate()
        
        return request
    }
    
    var settings: NRTRequestSettings {
        return NRTRequestSettings(method: .get)
    }
    
    var path: String {
        switch self {
        case .getTopStoriesId: return "/topstories.json"
        case .getStory(let id): return "/item/\(id).json"
        }
    }
    
    var parameters: [String : AnyObject]? {
        return nil
    }
}

protocol NetworkRouterProtocol {
    var settings: NRTRequestSettings {get}
    var path: String {get}
    var parameters: [String : AnyObject]? {get}
}


struct NRTRequestSettings {
    let method: HTTPMethod
    let encoding: ParameterEncoding
    
    init (method: HTTPMethod, encoding: ParameterEncoding? = nil) {
        self.method = method
        self.encoding = encoding ?? method.encoding
    }
}

extension HTTPMethod {
    var encoding: ParameterEncoding {
        switch self {
        case .get                   : return URLEncoding.default
        case .post, .put, .patch    : return JSONEncoding.default
        default                     : return URLEncoding.default
        }
    }
}
