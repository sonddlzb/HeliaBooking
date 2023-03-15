//
//  testRecentlyBookedViewController.swift
//  HeliaHotelBooking
//
//  Created by Hà Quang Hưng on 13/03/2023.
//

import UIKit

class TestRecentlyBookedViewController: UIViewController {

    let recentLyBookedView: RecentlyBookedView = {
        let recentlyBookedView = RecentlyBookedView(frame: CGRect(x: 0, y: 0,
                                                                  width: 400, height: 600))
        return recentlyBookedView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(recentLyBookedView)
    }

}
