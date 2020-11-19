//
//  NewsListViewController.swift
//  TempoTask
//
//  Created by Hussein Kishk on 18/11/2020.
//

import UIKit
import ProgressHUD

class NewsListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "NewsListItemCell", bundle: nil),
                               forCellReuseIdentifier: "NewsListItemCell")
        }
    }
    @IBOutlet weak var noResultLabel: UILabel!

    // MARK: - Properties
    let transition = NewsAnimationTransition()
    let presenter = NewsPresenter(newsAPIClient: NewsAPIClient())
    let searchController = UISearchController(searchResultsController: nil)
    var isLoading = false
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.handleRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        return refreshControl
    }()

    // MARK: - App life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Functions
    private func initialSetup() {
        setUpNavigationTitle()
        presenterSetup()
        setUpSearchController()
        setupTableView()
    }

    /// Function to setup presenter
    private func presenterSetup() {
        presenter.attachView(view: self)
        presenter.getNewsList(page: 1, searchKeyword: "apple")
    }

    /// Function to setup navigation title
    private func setUpNavigationTitle() {
        title = "Tempo News List"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        navigationController?.navigationBar.barTintColor = .lightGray
        navigationController?.navigationBar.tintColor = .lightGray
    }

    /// Function to setup table view
    private func setupTableView() {
        // Add Refresh Control to Table View
        tableView.refreshControl = refreshControl
    }

    /// Function to setup search controller
    private func setUpSearchController() {
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search here..."
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.tintColor = .white
        // TextField Color Customization
        if let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            if let backgroundView = textFieldInsideSearchBar.subviews.first {
                
                // Background color
                backgroundView.backgroundColor = UIColor.white
                
                // Rounded corner
                backgroundView.layer.cornerRadius = 10
                backgroundView.clipsToBounds = true
            }
        }
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    @objc func handleRefresh(_ sender: UIRefreshControl) {
        presenter.resetData()
        searchController.searchBar.text = ""
        tableView.reloadData()
        presenter.getNewsList(page: 1, searchKeyword: "apple")
        refreshControl.endRefreshing()
    }
}
extension NewsListViewController: NewsView {
    func startLoading() {
        isLoading = true
        ProgressHUD.show()
    }

    func finishLoading() {
        isLoading = false
        ProgressHUD.dismiss()
    }

    func reloadTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.reloadData()
    }
}

extension NewsListViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.reload(_:)), object: searchController.searchBar)
        perform(#selector(self.reload(_:)), with: searchController.searchBar, afterDelay: 0.75)

    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else {
            print("nothing to search")
            return
        }
        presenter.getNewsList(page: 1, searchKeyword: query)
        print(query)
    }

}
