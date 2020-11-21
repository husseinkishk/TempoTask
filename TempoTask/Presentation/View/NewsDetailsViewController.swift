//
//  NewsDetailsViewController.swift
//  TempoTask
//
//  Created by Hussein Kishk on 18/11/2020.
//

import UIKit
import SafariServices

class NewsDetailsViewController: UIViewController {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var urlView: UIView!
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    private func loadData(){
        guard let article = article else { return }
        if let data = article.image, let image = UIImage(data: data) {
            articleImageView.image = image
        } else {
            if let imagePath = article.urlToImage,
               let imageUrl = URL(string: imagePath) {
                articleImageView.kf.setImage(with: imageUrl)
            }
        }
        titleLabel.text = article.title
        descriptionLabel.text = article.articleDescription
        authorLabel.text = article.author
        contentLabel.text = article.content
        dateLabel.text = article.formattedPublishDate
        sourceLabel.text = article.source?.name
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func urlViewTapped(_ sender: Any) {
        if let urlStr = article?.source?.name?.handleHttpUrlValidation(), let url = URL(string: urlStr) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
}
