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

//    internal var aspectConstraint: NSLayoutConstraint? {
//        didSet {
//            if oldValue != nil {
//                articleImageView.removeConstraint(oldValue!)
//            }
//            if aspectConstraint != nil {
//                articleImageView.addConstraint(aspectConstraint!)
//            }
//        }
//    }

    var article: Article? {
        didSet {
            articleDescriptionLabel.text = article?.articleDescription
            articleSourceLabel.text = article?.source?.name
            guard
                let imagePath = article?.urlToImage,
                let imageUrl = URL(string: imagePath)
            else {
                return
            }
            
            articleImageView.kf.setImage(with: imageUrl, completionHandler:  { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    self.articleImageView.image = value.image
//                    self.setCustomImage(image: value.image)
                case .failure(let error):
                    print(error)
                }
            })
        }
    }

//    override func prepareForReuse() {
//        super.prepareForReuse()
//        aspectConstraint = nil
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
        cellContainerView.layer.borderWidth = 1
        cellContainerView.layer.borderColor = UIColor.gray.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func setCustomImage(image: UIImage) {
//        guard let articleImageView = articleImageView else { return }
//        let aspect = image.size.width / image.size.height
//        let constraint = NSLayoutConstraint(item: articleImageView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: articleImageView, attribute: NSLayoutConstraint.Attribute.height, multiplier: aspect, constant: 0.0)
//        aspectConstraint = constraint
//        articleImageView.image = image
//        article?.image = image.jpegData(compressionQuality: 1)
//    }
    
}
