//
//  ForgotPasswordViewController.swift
//  HeliaHotelBooking
//
//  Created by Hà Quang Hưng on 09/03/2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var btnSMS: TapableView!
    @IBOutlet weak var btnEmail: TapableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnSMSDidTap(_ sender: Any) {
        chooseBtn(tapableView: self.btnSMS)
        unChooseBtn(tapableView: self.btnEmail)
    }
    
    @IBAction func btnEmailDidTap(_ sender: Any) {
        chooseBtn(tapableView: self.btnEmail)
        unChooseBtn(tapableView: self.btnSMS)
    }
    
    
    @IBAction func btnContinueDidTap(_ sender: Any) {
        navigationController?.pushViewController(InsertCodeViewController(), animated: true)
    }
    
    
    @IBAction func popScreenDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    private func chooseBtn(tapableView: TapableView) {
        tapableView.borderWidth = 2
        tapableView.borderColor = R.color.crayola()
    }
    
    private func unChooseBtn(tapableView: TapableView) {
        tapableView.borderWidth = 1
        tapableView.borderColor = R.color.lightGray()
    }

}
