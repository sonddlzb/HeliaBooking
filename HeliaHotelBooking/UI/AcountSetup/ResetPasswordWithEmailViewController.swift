//
//  ResetPasswordWithEmailViewController.swift
//  HeliaHotelBooking
//
//  Created by Hà Quang Hưng on 10/03/2023.
//

import UIKit
import FirebaseAuth

class ResetPasswordWithEmailViewController: UIViewController {

    @IBOutlet weak var tapableViewSendEmail: TapableView!
    @IBOutlet weak var tapableViewLoginAgain: TapableView!
    @IBOutlet weak var emailTextField: SolarTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    func setUpView() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.placeholder = "Email"
        emailTextField.isHighlightedWhenEditting = true
        emailTextField.backgroundColor = R.color.lotion()
        emailTextField.borderColor = R.color.crayola()
        emailTextField.textField.paddingLeft = 10
        emailTextField.cornerRadius = 12
    }

    @IBAction func btnSendEmailDidTap(_ sender: TapableView) {
        let email = emailTextField.text
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                R.nib.notificationDialogView(withOwner: self)?.show(in: self.view, title: "Check email again",
                    message: "You entered the wrong email", image: R.image.ic_wrong())
            } else {
                R.nib.notificationDialogView(withOwner: self)?.show(in: self.view, title: "Check your email",
                    message: "Please check your email to complete the password reset")
                self.tapableViewSendEmail.isHidden = true
                self.tapableViewLoginAgain.isHidden = false
            }
        }
    }

    @IBAction func popScreenDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func didTapLoginAgainBtn(_ sender: Any) {
        navigationController?.pushViewController(SignInWithPassWordViewController(), animated: true)
    }

}
