//
//  HotelByTopicViewCell.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 10/03/2023.
//

import UIKit
import SVProgressHUD

class HotelByTopicViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!

    func bind(itemViewModel: HomeHotelsByTopicItemViewModel) {
        self.nameLabel.text = itemViewModel.hotel.name
        self.locationLabel.text = itemViewModel.hotel.location
        self.priceLabel.text = "\(itemViewModel.hotel.price)$"
        SVProgressHUD.show()
        itemViewModel.loadImageFrom { image in
            SVProgressHUD.dismiss()
            self.thumbnailImageView.image = image
        }
    }

    @IBAction func didTapMyBookmarkButton(_ sender: Any) {
    }
}
