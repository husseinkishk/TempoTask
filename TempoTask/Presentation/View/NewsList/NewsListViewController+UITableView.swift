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
        let articles = presenter.getAllArticles()
        for index in indexPaths {
            if index.row >= articles.count - 1, !isLoading {
                presenter.paginationHit()
                break
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter.getAllArticles().isEmpty {
            self.noResultLabel.isHidden = false
        } else {
            self.noResultLabel.isHidden = true
        }
        return presenter.getAllArticles().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsListItemCell") as? NewsListItemCell else {
            return UITableViewCell()
        }
        let article = presenter.getAllArticles()[indexPath.row]
        cell.article = article
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = presenter.getAllArticles()[indexPath.row]
        guard let newsDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "NewsDetailsViewController") as? NewsDetailsViewController else { return }
        newsDetailsViewController.transitioningDelegate = self
        newsDetailsViewController.modalPresentationStyle = .fullScreen

        newsDetailsViewController.article = article
        present(newsDetailsViewController, animated: true, completion: nil)
    }
}
