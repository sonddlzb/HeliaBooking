//
//  HomeViewController.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 10/03/2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var homeTabBar: HomeTabBar!

    private weak var currentViewController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeTabBar.delegate = self
        self.embedViewController(HomeTabViewController())
    }
}

extension HomeViewController {
    func embedViewController(_ viewController: UIViewController) {
        self.loadViewIfNeeded()
        guard viewController != self.currentViewController else {
            return
        }

        self.currentViewController?.view.removeFromSuperview()
        self.currentViewController?.removeFromParent()

        self.contentView.addSubview(viewController.view)
        viewController.view.fitSuperviewConstraint()

        self.addChild(viewController)
        self.currentViewController = viewController
    }
}

// MARK: -
extension HomeViewController: HomeTabBarDelegate {
    func homeTabBar(_ homeTabBar: HomeTabBar, didSelect homeTab: HomeTab) {
        switch homeTab {
        case .home:
            self.embedViewController(HomeTabViewController())
        case .search:
            print("embed SearchViewController")
        case .booking:
            print("embed BookingViewController")
        case .profile:
            print("embed ProfileViewController")
        }
    }
}
