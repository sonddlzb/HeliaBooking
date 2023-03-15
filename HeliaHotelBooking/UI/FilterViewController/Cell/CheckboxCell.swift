//
//  CheckboxCell.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 15/03/2023.
//

import UIKit

protocol CheckboxCellDelegate: AnyObject {
    func checkboxCellDidTapCheckBox(_ checkboxCell: CheckboxCell,
                                    itemViewModel: CheckboxItemViewModel)
}

class CheckboxCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!

    weak var delegate: CheckboxCellDelegate?
    var itemViewModel: CheckboxItemViewModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.imageView.borderWidth = 3
        self.imageView.borderColor = .crayola
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.layer.cornerRadius = 6.0
    }

    func bind(itemViewModel: CheckboxItemViewModel) {
        self.itemViewModel = itemViewModel
        self.imageView.image = itemViewModel.isSelected ? UIImage(named: "ic_remember") : nil
        self.nameLabel.text = itemViewModel.name
    }
    @IBAction func didTapCheckbox(_ sender: Any) {
        guard var itemViewModel = self.itemViewModel else {
            return
        }

        itemViewModel.isSelected = !itemViewModel.isSelected
        self.itemViewModel = itemViewModel
        self.imageView.image = itemViewModel.isSelected ? UIImage(named: "ic_remember") : nil
        self.delegate?.checkboxCellDidTapCheckBox(self, itemViewModel: itemViewModel)
    }
}
