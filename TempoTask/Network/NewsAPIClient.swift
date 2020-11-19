//
//  NewsAPIClient.swift
//  TempoTask
//
//  Created by Hussein Kishk on 18/11/2020.
//

import Foundation
import Alamofire

class NewsAPIClient {
    private func performRequest<T: Decodable>(route: NewsAPIRouter, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, Error>) -> Void) {
//        guard AppCommon.shared.checkConnectivity() else {
//            return
//        }
        AF.request(route).validate(statusCode: 200 ..< 300)
            .responseDecodable { (response: AFDataResponse<T>) in
                switch response.result {
                case .success(let model):
                    completion(.success(model))
                    break
                case .failure(let error):
                    debugPrint(error)
                    completion(.failure(error))
                }
        }
    }

    public func getNewsList(page: Int, searchKeyword: String, completion: @escaping (Result<NewsModel, Error>)->Void) {
        performRequest(route: NewsAPIRouter.getNewsList(page: page, searchKeyword: searchKeyword), completion: completion)
    }
}
