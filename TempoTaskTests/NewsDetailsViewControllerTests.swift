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
        newsDetailsViewController?.loadViewIfNeeded()
    }

    override func tearDown() {
        newsDetailsViewController = nil
        super.tearDown()
    }

}
