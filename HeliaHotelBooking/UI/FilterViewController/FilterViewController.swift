//
//  FilterViewController.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 14/03/2023.
//

import UIKit

class FilterViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var countryTopicView: TopicTabBarView!
    @IBOutlet private weak var compareTopicView: TopicTabBarView!
    @IBOutlet private weak var facilityCollectionView: UICollectionView!
    @IBOutlet private weak var accomadationTypeCollectionView: UICollectionView!

    // MARK: - Variables
    private var listCountries = ["Vietnam", "China", "India", "Thailand", "United Kingdom", "USA"]
    private var listFacilities = ["Wifi", "Breakfast", "Lunch", "Elevator", "Swimming Pool", "Fitness", "Gym", "Parking", "Tennis"]
    private var listAccomadationTypes = ["Hotel", "Apartment", "Villa", "Homestay"]
    private var currentSelectedCountries = "Vietnam"
    private var currentSelectedSortOption: SortOption = .highestPrice
    private var currentSelectedAccommadationTypes = ["Hotel"]
    private var currentSelectedFacilities = ["Wifi"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
    }

    private func config() {
        self.countryTopicView.datasource = self
        self.countryTopicView.delegate = self
        self.countryTopicView.fontSize = 18

        self.compareTopicView.datasource = self
        self.compareTopicView.delegate = self
        self.compareTopicView.fontSize = 18

        self.facilityCollectionView.showsVerticalScrollIndicator = false
        self.facilityCollectionView.showsHorizontalScrollIndicator = false
        self.facilityCollectionView.registerCell(type: CheckboxCell.self)
        self.facilityCollectionView.delegate = self
        self.facilityCollectionView.dataSource = self

        self.accomadationTypeCollectionView.showsVerticalScrollIndicator = false
        self.accomadationTypeCollectionView.showsHorizontalScrollIndicator = false
        self.accomadationTypeCollectionView.registerCell(type: CheckboxCell.self)
        self.accomadationTypeCollectionView.delegate = self
        self.accomadationTypeCollectionView.dataSource = self
    }
}

// MARK: - TopicTabBarViewDelegate, TopicTabBarViewDatasource
extension FilterViewController: TopicTabBarViewDelegate, TopicTabBarViewDatasource {
    func topicTabBarView(_ topicTabBarView: TopicTabBarView, didSelect topic: String) {
        if topicTabBarView == self.compareTopicView {

        } else {

        }
    }

    func listTopics(for topicTabBarView: TopicTabBarView) -> [String] {
        if topicTabBarView == self.compareTopicView {
            return SortOption.allCases.map { return $0.rawValue}
        } else {
            return self.listCountries
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(type: CheckboxCell.self, indexPath: indexPath) else {
            return UICollectionViewCell()
        }

        let isFacilitiesOption = collectionView == self.facilityCollectionView
        let name = isFacilitiesOption ? self.listFacilities[indexPath.row] :
            self.listAccomadationTypes[indexPath.row]
        let itemViewModel =  isFacilitiesOption ? CheckboxItemViewModel(name: name, isSelected: self.currentSelectedFacilities.contains(name))
        : CheckboxItemViewModel(name: name, isSelected: self.currentSelectedAccommadationTypes.contains(name))
        cell.bind(itemViewModel: itemViewModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == self.facilityCollectionView ??
    }
}
