//
//  RemoveDialogCell.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 13/03/2023.
//

import UIKit
import Kingfisher

class RemoveDialogCell: UICollectionViewCell {
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    func bind(itemViewModel: MyBookmarkItemViewModel) {
        self.imageView.setImage(with: itemViewModel.hotelThumbnailURL(), indicator: nil)
        self.nameLabel.text = itemViewModel.name()
        self.locationLabel.text = itemViewModel.location()
        self.priceLabel.text = itemViewModel.price()
    }
}
