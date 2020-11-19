//
//  Constants.swift
//  TempoTask
//
//  Created by Hussein Kishk on 18/11/2020.
//

import Foundation
struct Constants {
    
    struct ProductionServer {
        static let baseURL = "http://newsapi.org/v2/"
    }

    struct Urls {
        static let everything = "everything"
    }

    struct APIParameterKey {
        static let page = "page"
        static let q = "q"
        static let apiKey = "apiKey"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
