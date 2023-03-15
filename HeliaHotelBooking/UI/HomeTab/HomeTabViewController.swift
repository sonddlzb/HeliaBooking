//
//  HomeTabViewController.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 10/03/2023.
//

import UIKit
import FirebaseAuth

class HomeTabViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var homeHotelsByTopicView: HomeHotelsByTopicView!
    @IBOutlet private weak var nameLabel: UILabel!

    // MARK: - Variables
    private var currentTopic = "Recommended"

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
        self.fetchData(topic: self.currentTopic)
    }

    // MARK: - Config
    private func config() {
        self.homeHotelsByTopicView.delegate = self
        if let email = Auth.auth().currentUser?.email, let index = email.firstIndex(of: "@") {
            self.nameLabel.text = "Hello, " + String(email.prefix(upTo: index))
        }
    }

    private func fetchData(topic: String) {
        Database.shared.getHotelsBy(topic: topic) { listHotels in
            self.homeHotelsByTopicView.bind(viewModel: HomeHotelsByTopicViewModel(listHotels: listHotels))
        }
    }

    private func changeHotelFavoriteStatus(at hotel: Hotel, isFavorite: Bool) {
        Database.shared.updateHotelsFavoriteStatus(at: hotel, isFavorite: isFavorite) { result in
            if !result {
                FailedDialog.show(title: "Failed to update this hotel", message: "Something went wrong. Try again later!")
            }
        }
    }

    // MARK: - Actions
    @IBAction func didTapMyBookmarkButton(_ sender: Any) {
        let myBookmarkViewController = MyBookmarkViewController()
        myBookmarkViewController.delegate = self
        self.navigationController?.pushViewController(myBookmarkViewController, animated: true)
    }

    @IBAction func didTapSeeAllButton(_ sender: Any) {
        //next screen
    }
}

// MARK: - HomeHotelsByTopicViewDelegate
extension HomeTabViewController: HomeHotelsByTopicViewDelegate {
    func homeHotelsByTopicViewDidChangeFavoriteStatus(_ homeHotelsByTopicView: HomeHotelsByTopicView, at hotel: Hotel, isFavorite: Bool) {
        self.changeHotelFavoriteStatus(at: hotel, isFavorite: isFavorite)
    }

    func homeHotelsByTopicView(_ homeHotelsByTopicView: HomeHotelsByTopicView, didSelectAt topic: String) {
        self.currentTopic = topic
        self.fetchData(topic: topic)
    }
}

extension HomeTabViewController: MyBookmarkViewControllerDelegate {
    func myBookmarkViewControllerWantToReloadData(_ myBookmarkViewController: MyBookmarkViewController) {
        self.fetchData(topic: self.currentTopic)
    }
}
