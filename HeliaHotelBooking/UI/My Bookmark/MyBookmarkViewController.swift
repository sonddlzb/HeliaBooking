//
//  MyBookmarkViewController.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 13/03/2023.
//

protocol MyBookmarkViewControllerDelegate: AnyObject {
    func myBookmarkViewControllerWantToReloadData(_ myBookmarkViewController: MyBookmarkViewController)
}

private struct Const {
    static let contentInsets = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)
    static let cellPadding = 10.0
    static let cellHeight = 270.0
}

import UIKit

class MyBookmarkViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    // MARK: - Variables
    private var viewModel = MyBookmarkViewModel.makeEmpty()
    weak var delegate: MyBookmarkViewControllerDelegate?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
        self.fetchData()
    }

    private func config() {
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.contentInset = Const.contentInsets
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerCell(type: MyBookmarkCell.self)
    }

    private func fetchData() {
        Database.shared.getFavoriteHotels { listHotels in
            self.viewModel = MyBookmarkViewModel(listFavoriteHotels: listHotels)
            self.collectionView.reloadData()
        }
    }

    // MARK: - Actions
    @IBAction func backButtonDidTap(_ sender: TapableView) {
        self.delegate?.myBookmarkViewControllerWantToReloadData(self)
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MyBookmarkViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfFavoriteHotels()
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueCell(type: MyBookmarkCell.self, indexPath: indexPath) else {
            return UICollectionViewCell()
        }

        cell.delegate = self
        cell.bind(itemViewModel: self.viewModel.item(at: indexPath.row))
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MyBookmarkViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - Const.contentInsets.left -
                     Const.contentInsets.right - Const.cellPadding)/2
        let height = Const.cellHeight
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Const.cellPadding
    }
}

// MARK: - MyBookmarkCellDelegate
extension MyBookmarkViewController: MyBookmarkCellDelegate {
    func myBookmarkCellDidTapToRemoveFavorite(_ myBookmarkCell: MyBookmarkCell, itemViewModel: MyBookmarkItemViewModel) {
        let removeDialogView = RemoveDialogView.loadView()
        removeDialogView.delegate = self
        removeDialogView.show(in: self.view, itemViewModel: itemViewModel)
    }
}

extension MyBookmarkViewController: RemoveDialogViewDelegate {
    func removeDialogViewDidTapYesButton(_ removeDialogView: RemoveDialogView, hotel: Hotel) {
        Database.shared.updateHotelsFavoriteStatus(at: hotel, isFavorite: false) { _ in
            self.fetchData()
        }
    }

    func removeDialogViewDidTapCancelButton(_ removeDialogView: RemoveDialogView) {
    }
}
