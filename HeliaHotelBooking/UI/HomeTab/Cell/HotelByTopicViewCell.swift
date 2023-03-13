//
//  HotelByTopicViewCell.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 10/03/2023.
//

import UIKit

protocol HotelByTopicViewCellDelegate: AnyObject {
    func hotelByTopicViewCellDidChangeFavoriteStatus(_ hotelByTopicViewCell: HotelByTopicViewCell,
                                                     at hotel: Hotel, isFavorite: Bool)
}

class HotelByTopicViewCell: UICollectionViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    @IBOutlet private weak var favoriteImageView: UIImageView!

    weak var delegate: HotelByTopicViewCellDelegate?
    private var itemViewModel: HomeHotelsByTopicItemViewModel?
    private var isFavorite = false

    func bind(itemViewModel: HomeHotelsByTopicItemViewModel) {
        self.itemViewModel = itemViewModel
        self.nameLabel.text = itemViewModel.hotel.name
        self.locationLabel.text = itemViewModel.hotel.location
        self.priceLabel.text = "\(itemViewModel.hotel.price)$"
        itemViewModel.checkFavoriteStatus { isFavorite in
            self.isFavorite = isFavorite
            DispatchQueue.main.async {
                self.favoriteImageView.image = isFavorite ?
                UIImage(named: "ic_bookmark_selected") : UIImage(named: "ic_bookmark")
            }
        }

        self.thumbnailImageView.setImage(with: itemViewModel.hotelThumbnailURL(), indicator: .activity)
    }

    @IBAction func didTapMyBookmarkButton(_ sender: Any) {
        guard let itemViewModel = itemViewModel else {
            return
        }

        self.isFavorite = !isFavorite
        self.favoriteImageView.image = isFavorite ?
        UIImage(named: "ic_bookmark_selected") : UIImage(named: "ic_bookmark")
        self.delegate?.hotelByTopicViewCellDidChangeFavoriteStatus(self,
                                                                   at: itemViewModel.hotel,
                                                                   isFavorite: self.isFavorite)
    }
}
