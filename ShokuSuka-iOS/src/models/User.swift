//
//  User.swift
//  ShokuSuka-iOS
//
//  Created by AtsuyaSato on 2017/03/20.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation
import Decodable

struct User : Decodable{
    let email : String
    let firstName : String
    let lastName : String
    let gender : String
    let id : String
    let link : String
    let locale : String
    let name : String
    let timezone : Int
    let updatedTime : String
    let thumbnaiUrl : String
    
    static func decode(_ json: Any) throws -> User {
        return try User(
            email: json => "email",
            firstName:json => "first_name",
            lastName: json => "last_name",
            gender: json => "gender",
            id: json => "id",
            link: json => "link",
            locale: json => "locale",
            name: json => "name",
            timezone: json => "timezone",
            updatedTime: json => "updated_time",
            thumbnaiUrl: json => "picture" => "data" => "url"
        )
    }
}
