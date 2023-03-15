//
//  FilterViewController.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 14/03/2023.
//

import UIKit

private struct Const {
    static let cellPadding = 30.0
    static let checkboxSize = 20.0
    static let contentInset = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 0.0)
}

class FilterViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var countryTopicView: TopicTabBarView!
    @IBOutlet private weak var compareTopicView: TopicTabBarView!
    @IBOutlet private weak var facilityCollectionView: UICollectionView!
    @IBOutlet private weak var accomadationTypeCollectionView: UICollectionView!

    // MARK: - Variables
    private var listCountries = ["Vietnam", "China", "India", "Thailand", "United Kingdom", "USA"]
    private var listFacilities = ["Wifi", "Breakfast", "Lunch", "Elevator",
                                  "Swimming Pool", "Fitness", "Gym", "Parking", "Tennis"]
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

        self.facilityCollectionView.showsHorizontalScrollIndicator = false
        self.facilityCollectionView.registerCell(type: CheckboxCell.self)
        self.facilityCollectionView.isScrollEnabled = true
        self.facilityCollectionView.contentInset = Const.contentInset
        self.facilityCollectionView.delegate = self
        self.facilityCollectionView.dataSource = self

        self.accomadationTypeCollectionView.showsHorizontalScrollIndicator = false
        self.accomadationTypeCollectionView.registerCell(type: CheckboxCell.self)
        self.accomadationTypeCollectionView.isScrollEnabled = true
        self.accomadationTypeCollectionView.contentInset = Const.contentInset
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
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueCell(type: CheckboxCell.self, indexPath: indexPath) else {
            return UICollectionViewCell()
        }

        let isFacilitiesOption = collectionView == self.facilityCollectionView
        let name = isFacilitiesOption ? self.listFacilities[indexPath.row] :
            self.listAccomadationTypes[indexPath.row]
        let itemViewModel =  isFacilitiesOption ?
            CheckboxItemViewModel(name: name, isSelected: self.currentSelectedFacilities.contains(name), isFacility: true) :
            CheckboxItemViewModel(name: name, isSelected: self.currentSelectedAccommadationTypes.contains(name), isFacility: false)
        cell.bind(itemViewModel: itemViewModel)
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == self.facilityCollectionView ? self.listFacilities.count :
            self.listAccomadationTypes.count
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let font = Outfit.regularFont(size: CGFloat(18.0))
        let isFacilitiesOption = collectionView == self.facilityCollectionView
        let name = isFacilitiesOption ? self.listFacilities[indexPath.row] :
            self.listAccomadationTypes[indexPath.row]
        let atttributes =  [NSAttributedString.Key.font: font]
        let width = name.size(withAttributes: atttributes).width + Const.cellPadding + Const.checkboxSize
        let height = collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
}

// MARK: -
extension FilterViewController: CheckboxCellDelegate {
    func checkboxCellDidTapCheckBox(_ checkboxCell: CheckboxCell,
                                    itemViewModel: CheckboxItemViewModel) {
        if itemViewModel.isSelected {
            if itemViewModel.isFacility {
                guard !self.currentSelectedFacilities.contains(itemViewModel.name) else {
                    return
                }

                self.currentSelectedFacilities.append(itemViewModel.name)
            } else {
                guard !self.currentSelectedAccommadationTypes.contains(itemViewModel.name) else {
                    return
                }

                self.currentSelectedAccommadationTypes.append(itemViewModel.name)
            }
        } else {
            if itemViewModel.isFacility {
                guard self.currentSelectedFacilities.contains(itemViewModel.name) else {
                    return
                }

                self.currentSelectedFacilities.removeObject(itemViewModel.name)
            } else {
                guard self.currentSelectedAccommadationTypes.contains(itemViewModel.name) else {
                    return
                }

                self.currentSelectedAccommadationTypes.removeObject(itemViewModel.name)
            }
        }
    }
}
