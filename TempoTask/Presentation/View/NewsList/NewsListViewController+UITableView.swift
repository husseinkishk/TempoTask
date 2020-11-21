//
//  NewsListViewController+UITableView.swift
//  TempoTask
//
//  Created by Hussein Kishk on 18/11/2020.
//

import Foundation
import UIKit

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        let articlesCount = presenter.getArticlesCount()
        for index in indexPaths {
            if index.row >= articlesCount - 1, !isLoading {
                presenter.paginationHit()
                break
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getArticlesCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListItemCell") as? NewsListItemCell else {
            return UITableViewCell()
        }
        let article = presenter.getArticle(row: indexPath.row)
        cell.article = article
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = presenter.getArticle(row: indexPath.row)
        guard let newsDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "NewsDetailsViewController") as? NewsDetailsViewController else { return }
        newsDetailsViewController.transitioningDelegate = self
        newsDetailsViewController.modalPresentationStyle = .fullScreen

        newsDetailsViewController.article = article
        present(newsDetailsViewController, animated: true, completion: nil)
    }
}
