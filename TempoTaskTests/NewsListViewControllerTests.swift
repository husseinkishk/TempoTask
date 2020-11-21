//
//  NewsListViewControllerTests.swift
//  NewsListViewControllerTests
//
//  Created by Hussein Kishk on 18/11/2020.
//

import XCTest
@testable import TempoTask

class NewsListViewControllerTests: XCTestCase {
    
    var newsListViewController: NewsListViewController?
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController
        else {
            XCTFail()
            return
        }
        newsListViewController = navigationController.viewControllers.first as? NewsListViewController
        newsListViewController?.loadViewIfNeeded()
    }

    override func tearDown() {
        newsListViewController = nil
        super.tearDown()
    }

    func test_outlets_shouldBeConnected() {
        XCTAssertNotNil(newsListViewController?.tableView, "tableView")
        XCTAssertNotNil(newsListViewController?.noResultLabel, "Label")
    }

    func test_tableViewDelegates_shouldBeConnected() {
        newsListViewController?.reloadTableView()
        XCTAssertNotNil(newsListViewController?.tableView.dataSource, "dataSource")
        XCTAssertNotNil(newsListViewController?.tableView.delegate, "delegate")
    }

    func test_navigationTitle() {
        XCTAssertEqual(newsListViewController?.title, "Tempo News List")
        XCTAssertEqual(newsListViewController?.navigationController?.navigationBar.barTintColor,
                       UIColor.lightGray)
        XCTAssertEqual(newsListViewController?.navigationController?.navigationBar.tintColor,
                       UIColor.lightGray)
    }

    func test_presenter_shouldBeConnected() {
        XCTAssertNotNil(newsListViewController?.presenter)
        XCTAssertNotNil(newsListViewController?.presenter.newsView)
    }
    
    func test_searchController_shouldBeSet() {
        XCTAssertNotNil(newsListViewController?.searchController.searchResultsUpdater)
        XCTAssertEqual(newsListViewController?.searchController.searchBar.placeholder,
                       "Search here...")
        XCTAssertEqual(newsListViewController?.searchController.searchBar.barTintColor,
                       UIColor.white)
        XCTAssertEqual(newsListViewController?.searchController.searchBar.tintColor,
                       UIColor.white)
    }
    
    func test_handleRefresh() {
        guard let refreshControl = newsListViewController?.refreshControl else {
            XCTFail()
            return
        }
        newsListViewController?.handleRefresh(refreshControl)

        XCTAssertTrue((newsListViewController?.searchController.searchBar.text ?? "Not empty").isEmpty)

        XCTAssertEqual(newsListViewController?.presenter.page, 1)
        
    }
}
