//
//  ShokuSukaRequest.swift
//  ShokuSuka-iOS
//
//  Created by AtsuyaSato on 2017/03/20.
//  Copyright © 2017年 Atsuya Sato. All rights reserved.
//

import Foundation
import APIKit
import Decodable
protocol ShokuSukaRequest: Request {
    
}

extension ShokuSukaRequest {
    var baseURL: URL {
        return URL(string: "https://theoldmoon0602.tk/inspix")!
    }
    func intercept(urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        let cookies = HTTPCookieStorage.shared.cookies(for: urlRequest.url!)
        let header  = HTTPCookie.requestHeaderFields(with: cookies!)
        urlRequest.allHTTPHeaderFields = header
        
        print(urlRequest)
        return urlRequest
    }
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard (200..<300).contains(urlResponse.statusCode) else {
            throw ShokuSukaError(object: object)
        }
        return object
    }
}
struct ShokuSukaError: Error {
    let message: String
    
    init(object: Any) {
        let dictionary = object as? [String: Any]
        message = (dictionary?["error"] as? Array)?.first ?? "Unknown error occurred"
    }
}
extension ShokuSukaRequest where Self.Response: Decodable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Self.Response {
        do {
            let response = try APIResponse<Self.Response>.decode(object)
            guard let data = response.data else {
                throw ResponseError.unexpectedObject(object)
            }
            
            return data
        } catch {
            throw ResponseError.unexpectedObject(object)
        }
    }
    
}

