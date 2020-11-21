//
//  NewsPresenterTests.swift
//  TempoTaskTests
//
//  Created by Hussein Kishk on 21/11/2020.
//

import XCTest
@testable import TempoTask


class NewsPresenterTests: XCTestCase {

    var presenter: NewsPresenter?
    
    override func setUp() {
        super.setUp()
        presenter = NewsPresenter(newsAPIClient: NewsAPIClientMock())
        presenter?.getNewsList(page: 1, searchKeyword: "a")
    }

    override func tearDown() {
        presenter = nil
        super.tearDown()
    }

    func testResetData() {
        presenter?.resetData()
        guard let articles = presenter?.newsList?.articles else {
            XCTFail()
            return
        }
        XCTAssertTrue(articles.isEmpty)
    }

    func getArticlesCountTest() {
        XCTAssertEqual(presenter?.getArticlesCount(),
                       presenter?.newsList?.articles.count ?? 0)
    }

    func getArticleAtRowTest() {
        let row = 0
        let article = presenter?.getArticle(row: row)
        XCTAssertEqual(article, presenter?.newsList?.articles[row])
    }
}
