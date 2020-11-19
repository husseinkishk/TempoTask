//
//  NewsAPIRouter.swift
//  TempoTask
//
//  Created by Hussein Kishk on 18/11/2020.
//

import Foundation
import Alamofire

enum NewsAPIRouter: URLRequestConvertible {
    case getNewsList(page: Int, searchKeyword: String)

    private var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getNewsList:
            return Constants.Urls.everything
        }
    }

    private var parameters: [String: Any]? {
        switch self {
        case .getNewsList(let page, let searchKeyword):
            return [Constants.APIParameterKey.page: page,
                    Constants.APIParameterKey.q: searchKeyword,
                    Constants.APIParameterKey.apiKey: "e7af6c2c186c4e969beb7746f7d4c52e"]
        //"c2b1ab93de5f465b890c75089bda1de8"]
        }
    }

    private var encoding: ParameterEncoding {
        switch self {
        case .getNewsList:
            return URLEncoding.default
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try Constants.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
//        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        guard let parameters = parameters else {
            return urlRequest
        }
        //        do {
        //            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .sortedKeys)
        //        } catch {
        //            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        //        }
        return try encoding.encode(urlRequest, with: parameters)
    }

}

