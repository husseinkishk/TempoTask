//
//  NewsDetailsViewControllerTests.swift
//  TempoTaskTests
//
//  Created by Hussein Kishk on 19/11/2020.
//

import XCTest
@testable import TempoTask

class NewsDetailsViewControllerTests: XCTestCase {

    var newsDetailsViewController: NewsDetailsViewController?
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        newsDetailsViewController = storyboard.instantiateViewController(identifier: "NewsDetailsViewController") as? NewsDetailsViewController
        newsDetailsViewController?.article = fetchArticleFromStubs()
        newsDetailsViewController?.loadViewIfNeeded()
    }

    override func tearDown() {
        newsDetailsViewController = nil
        super.tearDown()
    }

    func testLoadData() {
        XCTAssertEqual(newsDetailsViewController?.titleLabel.text,
                       newsDetailsViewController?.article?.title)

        XCTAssertEqual(newsDetailsViewController?.descriptionLabel.text,
                       newsDetailsViewController?.article?.articleDescription)

        XCTAssertEqual(newsDetailsViewController?.authorLabel.text,
                       newsDetailsViewController?.article?.author)

        XCTAssertEqual(newsDetailsViewController?.contentLabel.text,
                       newsDetailsViewController?.article?.content)

        XCTAssertEqual(newsDetailsViewController?.dateLabel.text,
                       newsDetailsViewController?.article?.formattedPublishDate)

        XCTAssertEqual(newsDetailsViewController?.sourceLabel.text,
                       newsDetailsViewController?.article?.source?.name)
    }
    
    func fetchArticleFromStubs() -> Article? {
        if let newsStubPath = Bundle.main.url(forResource: "news_stub_for_testing", withExtension: "json") {
            do {
                let data = try Data(contentsOf: newsStubPath, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let newsModel = try decoder.decode(NewsModel.self, from: data)
                
                let article = newsModel.articles.first
                return article
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
        return nil
    }
}
