//
//  ViewController.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 28/02/2023.
//

import UIKit
import FirebaseAuth

class RootViewController: BaseViewControler {

    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            navigationController?.pushViewController(TestRecentlyBookedViewController(), animated: true)
        } else {
            navigationController?.pushViewController(IntroductionViewController(), animated: true)
        }
    }
}
