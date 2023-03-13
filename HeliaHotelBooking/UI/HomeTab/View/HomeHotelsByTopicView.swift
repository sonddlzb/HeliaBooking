//
//  HomeHotelsByTopicView.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 10/03/2023.
//
private struct Const {
    static let cellHeight = 300.0
    static let cellSpacing = 12.0
}

protocol HomeHotelsByTopicViewDelegate: AnyObject {
    func homeHotelsByTopicView(_ homeHotelsByTopicView: HomeHotelsByTopicView, didSelectAt topic: String)
    func homeHotelsByTopicViewDidChangeFavoriteStatus(_ homeHotelsByTopicView: HomeHotelsByTopicView, at hotel: Hotel, isFavorite: Bool)
}

import UIKit

class HomeHotelsByTopicView: UIView {
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()

    private lazy var topicTabBarView: TopicTabBarView = {
        let topicTabBarView = TopicTabBarView()
        topicTabBarView.translatesAutoresizingMaskIntoConstraints = false
        topicTabBarView.delegate = self
        topicTabBarView.datasource = self
        return topicTabBarView
    }()

    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: Const.cellSpacing, bottom: 0.0, right: 0.0)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCell(type: HotelByTopicViewCell.self)
        return collectionView
    }()

    // MARK: - Variables
    var listTopics = ["Recommended", "Popular", "Trending"]
    var viewModel = HomeHotelsByTopicViewModel.makeEmpty()
    weak var delegate: HomeHotelsByTopicViewDelegate?

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpView()

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUpView()
    }

    private func setUpView() {
        self.addSubview(containerView)
        self.containerView.addSubview(topicTabBarView)
        self.containerView.addSubview(collectionView)
        collectionView.layoutIfNeeded()
        self.addLayoutConstraints()
    }

    private func addLayoutConstraints() {
        self.containerView.fitSuperviewConstraint()
        NSLayoutConstraint.activate([
            self.topicTabBarView.heightAnchor.constraint(equalToConstant: 30.0),
            self.topicTabBarView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.topicTabBarView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            self.topicTabBarView.topAnchor.constraint(equalTo: self.containerView.topAnchor),

            self.collectionView.topAnchor.constraint(equalTo: self.topicTabBarView.bottomAnchor, constant: 16.0),
            self.collectionView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor),
            self.collectionView.heightAnchor.constraint(equalToConstant: Const.cellHeight + 20),
            self.collectionView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor)
        ])
    }

    func bind(viewModel: HomeHotelsByTopicViewModel) {
        self.viewModel = viewModel
        self.collectionView.reloadData()
    }
}

// MARK: - TopicTabBarViewDelegate, TopicTabBarViewDatasource
extension HomeHotelsByTopicView: TopicTabBarViewDelegate, TopicTabBarViewDatasource {
    func topicTabBarView(_ topicTabBarView: TopicTabBarView, didSelect topic: String) {
        self.delegate?.homeHotelsByTopicView(self, didSelectAt: topic)
    }

    func listTopics(for topicTabBarView: TopicTabBarView) -> [String] {
        return self.listTopics
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension HomeHotelsByTopicView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueCell(type: HotelByTopicViewCell.self, indexPath: indexPath) ?? HotelByTopicViewCell()
        cell.delegate = self
        cell.bind(itemViewModel: self.viewModel.item(at: indexPath.row))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfHotels()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeHotelsByTopicView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Const.cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width*2/3, height: Const.cellHeight)
    }
}

// MARK: - HotelByTopicViewCellDelegate
extension HomeHotelsByTopicView: HotelByTopicViewCellDelegate {
    func hotelByTopicViewCellDidChangeFavoriteStatus(_ hotelByTopicViewCell: HotelByTopicViewCell, at hotel: Hotel, isFavorite: Bool) {
        self.delegate?.homeHotelsByTopicViewDidChangeFavoriteStatus(self, at: hotel, isFavorite: isFavorite)
    }
}
