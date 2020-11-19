//
//  NewsListViewController+UIViewControllerTransitioningDelegate.swift
//  TempoTask
//
//  Created by Hussein Kishk on 18/11/2020.
//

import Foundation
import UIKit

// MARK: - UIViewControllerTransitioningDelegate

extension NewsListViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard
            let selectedIndexPathCell = tableView.indexPathForSelectedRow,
            let selectedCell = tableView.cellForRow(at: selectedIndexPathCell) as? NewsListItemCell,
            let rootView = UIApplication.shared.windows.filter({$0.isKeyWindow}).first,
            let globalFrame = selectedCell.articleImageView.superview?.convert(selectedCell.articleImageView.frame, to: rootView)
        else {
            return nil
        }
        
        transition.originFrame = globalFrame
        transition.originFrame = CGRect(
          x: transition.originFrame.origin.x,
          y: transition.originFrame.origin.y - 44,
          width: transition.originFrame.size.width,
          height: transition.originFrame.size.height
        )
        
        transition.presenting = true
        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
