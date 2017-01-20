//
//  AlamofireHelpers.swift
//  HackerNews
//
//  Created by Ellina Kuznetcova on 20/01/2017.
//  Copyright © 2017 Ellina Kuznetcova. All rights reserved.
//

import Foundation

extension DataRequest {
    
    func responseObject<T: Mappable>(_ completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
            guard error == nil else {
                return .failure(error!)
            }
            
            let result = Request.serializeResponseJSON(options: .allowFragments, response: response, data: data, error: error)
            
            switch result {
            case .success(let value):
                
                guard var object = T(JSON: ["value": value as AnyObject]) else {return .failure(NSError())}
                
                object = Mapper<T>().map(JSONObject: ["value": value as AnyObject], toObject: object)
                
                return .success(object)
                
            case .failure(let error):
                if let object = T(JSON: [:]) , data?.count == 0 {
                    return .success(object)
                }
                return .failure(error)
            }
        }
        
        return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
}
