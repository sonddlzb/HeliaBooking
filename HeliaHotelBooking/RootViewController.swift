//
//  ViewController.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 28/02/2023.
//

import UIKit

class RootViewController: BaseViewControler {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.pushViewController(IntroductionViewController(), animated: true)
    }
}
