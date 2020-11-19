//
//  NewsDetailsViewController.swift
//  TempoTask
//
//  Created by Hussein Kishk on 18/11/2020.
//

import UIKit

class NewsDetailsViewController: UIViewController {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sourceButton: UIButton!
    
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
        dateLabel.text = article.publishedAt
        sourceButton.setTitle(article.source?.name, for: .normal)
        
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func openSourceTapped(_ sender: Any) {
        if let urlStr = article?.source?.name,
           let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
        }
    }
}
