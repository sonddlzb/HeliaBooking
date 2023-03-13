//
//  RemoveDialogView.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 13/03/2023.
//

import UIKit

private struct Const {
    static let contentInset = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)
}

protocol RemoveDialogViewDelegate: AnyObject {
    func removeDialogViewDidTapCancelButton(_ removeDialogView: RemoveDialogView)
    func removeDialogViewDidTapYesButton(_ removeDialogView: RemoveDialogView, hotel: Hotel)
}

class RemoveDialogView: UIView {

    // MARK: - Outlets
    @IBOutlet private weak var backgroundView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Variables
    weak var delegate: RemoveDialogViewDelegate?
    private var itemViewModel: MyBookmarkItemViewModel?

    static func loadView() -> RemoveDialogView {
        return RemoveDialogView.loadView(fromNib: "RemoveDialogView") ?? RemoveDialogView()
    }

    // MARK: - Public method
    func show(in view: UIView, itemViewModel: MyBookmarkItemViewModel) {
        self.itemViewModel = itemViewModel
        self.alpha = 0
        view.addSubview(self)
        self.fitSuperviewConstraint()
        self.config()
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }

    func dismiss() {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }

    private func config() {
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.isScrollEnabled = false
        self.collectionView.registerCell(type: RemoveDialogCell.self)
        self.collectionView.contentInset = Const.contentInset
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    // MARK: - Touches began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if touches.first?.view == self.backgroundView {
            self.dismiss()
        }
    }

    @IBAction func yesButtonDidTap(_ sender: TapableView) {
        if let hotel = self.itemViewModel?.favoriteHotel {
            self.delegate?.removeDialogViewDidTapYesButton(self, hotel: hotel)
        }

        self.dismiss()
    }

    @IBAction func cancelButtonDidTap(_ sender: TapableView) {
        self.delegate?.removeDialogViewDidTapCancelButton(self)
        self.dismiss()
    }

}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension RemoveDialogView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueCell(type: RemoveDialogCell.self, indexPath: indexPath), let itemViewModel = self.itemViewModel else {
            return UICollectionViewCell()
        }

        cell.bind(itemViewModel: itemViewModel)
        return cell
    }
}

extension RemoveDialogView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.frame.width - Const.contentInset.left - Const.contentInset.right
        let height = self.collectionView.frame.height - Const.contentInset.top - Const.contentInset.bottom
        return CGSize(width: width, height: height)
    }
}
