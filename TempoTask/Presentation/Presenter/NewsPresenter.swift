//
//  NewsPresenter.swift
//  TempoTask
//
//  Created by Hussein Kishk on 18/11/2020.
//

import Foundation

protocol NewsView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func reloadTableView()
    func showNoResultsLabel()
}

class NewsPresenter {
    private let newsAPIClient: NewsAPIClient
    weak var newsView: NewsView?
    var newsList: NewsModel?
    var page = 1
    private var shouldPaginate = false
    private var query = ""
    
    init(newsAPIClient: NewsAPIClient) {
        self.newsAPIClient = newsAPIClient
    }
    
    func attachView(view: NewsView) {
        newsView = view
    }
    
    func detachView() {
        newsView = nil
    }
    
    func resetData() {
        newsList?.articles.removeAll()
        page = 1
    }
        
    func getArticle(row: Int) -> Article? {
        newsList?.articles[row]
    }


    func getArticlesCount() -> Int {
        newsList?.articles.count ?? 0
    }
    
    func getNewsList(page: Int, searchKeyword: String, shouldPaginate: Bool = false) {
        if !shouldPaginate {
            self.newsView?.startLoading()
        }
        query = searchKeyword
        newsAPIClient.getNewsList(page: page, searchKeyword: searchKeyword) { [weak self] result in
            guard let self = self else { return }
            self.newsView?.finishLoading()
            switch result {
            case .success(let news):
                if news.articles.isEmpty {
                    self.newsView?.showNoResultsLabel()
                } else {
                    if shouldPaginate {
                        self.newsList?.articles.append(contentsOf: news.articles)
                    } else {
                        self.newsList = news
                    }
                    self.newsView?.reloadTableView()
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func paginationHit() {
        guard let articlesCount = newsList?.articles.count,
              let total = newsList?.totalResults,
              articlesCount < total else {
            return
        }
        page += 1
        getNewsList(page: page, searchKeyword: query, shouldPaginate: true)
    }
}
