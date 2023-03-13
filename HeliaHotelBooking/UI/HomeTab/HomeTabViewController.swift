//
//  HomeTabViewController.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 10/03/2023.
//

import UIKit
import FirebaseAuth

class HomeTabViewController: UIViewController {

    @IBOutlet private weak var homeHotelsByTopicView: HomeHotelsByTopicView!
    @IBOutlet private weak var nameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
        self.fetchData(topic: "Recommended")
    }

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
}

// MARK: - HomeHotelsByTopicViewDelegate
extension HomeTabViewController: HomeHotelsByTopicViewDelegate {
    func homeHotelsByTopicView(_ homeHotelsByTopicView: HomeHotelsByTopicView, didSelectAt topic: String) {
        self.fetchData(topic: topic)
    }
}
