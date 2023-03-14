//
//  MyBookmarkCell.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 13/03/2023.
//

import UIKit

protocol MyBookmarkCellDelegate: AnyObject {
    func myBookmarkCellDidTapToRemoveFavorite(_ myBookmarkCell: MyBookmarkCell, itemViewModel: MyBookmarkItemViewModel)
}

class MyBookmarkCell: UICollectionViewCell {

    // MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    // MARK: - Variables
    weak var delegate: MyBookmarkCellDelegate?
    private var itemViewModel: MyBookmarkItemViewModel?

    func bind(itemViewModel: MyBookmarkItemViewModel) {
        self.itemViewModel = itemViewModel
        self.imageView.setImage(with: itemViewModel.hotelThumbnailURL(), indicator: .activity)

        self.nameLabel.text = itemViewModel.name()
        self.locationLabel.text = itemViewModel.location()
        self.priceLabel.text = itemViewModel.price()
    }

    @IBAction func didTapFavoriteButton(_ sender: Any) {
        if let itemViewModel = itemViewModel {
            self.delegate?.myBookmarkCellDidTapToRemoveFavorite(self, itemViewModel: itemViewModel)
        }
    }
}
