//
//  NewsListItemCell.swift
//  TempoTask
//
//  Created by Hussein Kishk on 18/11/2020.
//

import UIKit
import Kingfisher

class NewsListItemCell: UITableViewCell {

    @IBOutlet weak var cellContainerView: UIView!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var articleSourceLabel: UILabel!

    var article: Article? {
        didSet {
            articleDescriptionLabel.text = article?.articleDescription
            articleSourceLabel.text = article?.source?.name
            guard let imagePath = article?.urlToImage,
                  let imageUrl = URL(string: imagePath) else {
                return
            }

            articleImageView.kf.setImage(with: imageUrl, completionHandler:  { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    self.article?.image = value.image.jpegData(compressionQuality: 1)
                    self.articleImageView.image = value.image
                case .failure(let error):
                    print(error)
                }
            })
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        cellContainerView.layer.borderWidth = 1
        cellContainerView.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
