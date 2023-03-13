//
//  ForgotPasswordViewController.swift
//  HeliaHotelBooking
//
//  Created by Hà Quang Hưng on 09/03/2023.
//

import UIKit

enum ContactDetails: String {
    case email
    case sms
}

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var btnSMS: TapableView!
    @IBOutlet weak var btnEmail: TapableView!
    private var contactDetail: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnSMSDidTap(_ sender: Any) {
        chooseBtn(tapableView: self.btnSMS)
        unChooseBtn(tapableView: self.btnEmail)
        contactDetail = ContactDetails.sms.rawValue
    }

    @IBAction func btnEmailDidTap(_ sender: Any) {
        chooseBtn(tapableView: self.btnEmail)
        unChooseBtn(tapableView: self.btnSMS)
        contactDetail = ContactDetails.email.rawValue
    }

    @IBAction func btnContinueDidTap(_ sender: Any) {
        switch contactDetail {
        case ContactDetails.sms.rawValue:
            navigationController?.pushViewController(InsertCodeViewController(), animated: true)
        case ContactDetails.email.rawValue:
            navigationController?.pushViewController(ResetPasswordWithEmailViewController(), animated: true)
        default:
            print("contact details")
        }
    }

    @IBAction func popScreenDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    private func chooseBtn(tapableView: TapableView) {
        tapableView.borderWidth = 2
        tapableView.borderColor = .crayola
    }

    private func unChooseBtn(tapableView: TapableView) {
        tapableView.borderWidth = 1
        tapableView.borderColor = .lightGray
    }

}
