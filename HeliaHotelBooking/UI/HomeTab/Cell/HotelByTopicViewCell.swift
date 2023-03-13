//
//  HotelByTopicViewCell.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 10/03/2023.
//

import UIKit
import SVProgressHUD

protocol HotelByTopicViewCellDelegate: AnyObject {
    func hotelByTopicViewCellDidChangeFavoriteStatus(_ hotelByTopicViewCell: HotelByTopicViewCell, at hotel: Hotel, isFavorite: Bool)
}

class HotelByTopicViewCell: UICollectionViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var favoriteImageView: UIImageView!

    weak var delegate: HotelByTopicViewCellDelegate?
    private var itemViewModel: HomeHotelsByTopicItemViewModel?

    func bind(itemViewModel: HomeHotelsByTopicItemViewModel) {
        self.itemViewModel = itemViewModel
        self.nameLabel.text = itemViewModel.hotel.name
        self.locationLabel.text = itemViewModel.hotel.location
        self.priceLabel.text = "\(itemViewModel.hotel.price)$"
        self.favoriteImageView.image = itemViewModel.hotel.isFavorite ? R.image.ic_bookmark() : R.image.ic_bookmark_selected()
        SVProgressHUD.show()
        itemViewModel.loadImageFrom { image in
            SVProgressHUD.dismiss()
            self.thumbnailImageView.image = image
        }
    }

    @IBAction func didTapMyBookmarkButton(_ sender: Any) {
        guard let itemViewModel = itemViewModel else {
            return
        }

        itemViewModel.hotel.isFavorite = !itemViewModel.hotel.isFavorite
        self.favoriteImageView.image = itemViewModel.hotel.isFavorite ? R.image.ic_bookmark() : R.image.ic_bookmark_selected()
        self.delegate?.hotelByTopicViewCellDidChangeFavoriteStatus(self, at: itemViewModel.hotel, isFavorite: itemViewModel.hotel.isFavorite)
    }
}
