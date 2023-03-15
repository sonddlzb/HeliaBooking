//
//  RecentlyBookedViewController.swift
//  HeliaHotelBooking
//
//  Created by Hà Quang Hưng on 10/03/2023.
//

import UIKit
import FirebaseAuth

struct Constants {
    static let height = 140.0
}

class RecentlyBookedView: UIView {
    var limitCollectionViewCell: Int = 10
    private lazy var collectionView: UICollectionView = {
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
            layout.scrollDirection = .vertical

            return UICollectionView(frame: self.frame, collectionViewLayout: layout)
    }()
    var listRecentlyBooked: [Hotel] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()
        self.initData()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUpView()
        self.initData()
    }

    private func setUpView() {
        self.collectionView.backgroundColor = .lotion
        self.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.fitSuperviewConstraint()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.registerCell(type: RecentlyBookedCollectionViewCell.self)
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.showsVerticalScrollIndicator = false
    }

    private func initData() {
        Database.shared.getHotelsSortBynumberOfBookedTimes(size: limitCollectionViewCell) { listHotels in
            self.listRecentlyBooked = listHotels
            self.collectionView.reloadData()
        }
    }
}

extension RecentlyBookedView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listRecentlyBooked.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueCell(type: RecentlyBookedCollectionViewCell.self, indexPath: indexPath)!
        let bookedCell = listRecentlyBooked[indexPath.row]
        cell.initData(location: bookedCell.location,
                      price: bookedCell.price, name: bookedCell.name, urlImage: bookedCell.galleryURL.first!)
        return cell
    }
}

extension RecentlyBookedView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: Constants.height)
        }
}
