//
//  FBPosts.swift
//  ShokuSuka-iOS
//
//  Created by AtsuyaSato on 2017/03/20.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation
import Decodable

struct FBPosts : Decodable{
    let message : String
    let name : String
    let facebookId : String
    let urls : [url]
    
    static func decode(_ json: Any) throws -> FBPosts {
        return try FBPosts(
            message: json => "message",
            name:json => "name",
            facebookId: json => "facebookId",
            urls: json => "urls"
        )
    }
}
struct url : Decodable {
    let imageUrl : String
    static func decode(_ json: Any) throws -> url {
        return try url(
            imageUrl: json => "image_url"
        )
    }
}
