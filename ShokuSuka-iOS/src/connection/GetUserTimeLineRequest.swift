//
//  GetUserTimeLineRequest.swift
//  ShokuSuka-iOS
//
//  Created by AtsuyaSato on 2017/03/20.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation
import APIKit
import Decodable

struct GetUserTimeLineRequest : ShokuSukaRequest {
    typealias Response = TimeLineResponse
    
    var method: HTTPMethod {
        return .get
    }
    var path: String {
        return "/posts/getactivity"
    }
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> TimeLineResponse {
        print(object)
        
        return try TimeLineResponse.decode(object)
    }
}
struct TimeLineResponse: Decodable {
    let fbPosts : [FBPosts]
    
    public static func decode(_ json: Any) throws -> TimeLineResponse {
        return try TimeLineResponse(
            fbPosts: json => "data"
        )
    }
}
