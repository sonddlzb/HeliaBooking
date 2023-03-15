//
//  RecentlyBookedCollectionViewCell.swift
//  HeliaHotelBooking
//
//  Created by Hà Quang Hưng on 10/03/2023.
//

import UIKit

class RecentlyBookedCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var galleryImage: UIImageView!
    @IBOutlet weak var uiActivity: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func initData(location: String, price: Double, name: String, urlImage: String) {
        self.locationLabel.text = location
        self.priceLabel.text = String(price)
        self.nameLabel.text = name
        if let url = URL(string: urlImage) {
            url.loadImage { image in
                self.galleryImage.image = image
                self.uiActivity.isHidden = true
            }
        }
    }

}
