//
//  CheckboxCell.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 15/03/2023.
//

import UIKit

class CheckboxCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.borderWidth = 2
        self.imageView.borderColor =.crayola
    }

    func bind(itemViewModel: CheckboxItemViewModel) {
        self.imageView.image = itemViewModel.isSelected ? UIImage(named: "ic_remember") : nil
        self.nameLabel.text = itemViewModel.name
    }
}
