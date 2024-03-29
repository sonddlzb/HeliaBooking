//
//  SignInViewController.swift
//  HeliaHotelBooking
//
//  Created by Hà Quang Hưng on 02/03/2023.
//

import UIKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func facebookLoginAction(_ sender: Any) {
        FacebookSignInManager.shared.delegate = self
        FacebookSignInManager.shared.signIn(withPresenting: self)
    }

    @IBAction func signInWithPasswordAction(_ sender: Any) {
        navigationController?.pushViewController(SignInWithPassWordViewController(), animated: true)
    }

    @IBAction func didTapSignUp(_ sender: Any) {
        self.navigationController?.pushViewController(CreateAccountViewController(), animated: true)
    }

    @IBAction func didTapSignInWithGoogle(_ sender: TapableView) {
        GoogleSignInManager.shared.delegate = self
        GoogleSignInManager.shared.signIn(withPresenting: self)
    }
}

extension SignInViewController: FacebookSignInDelegate {
    func facebookSignInManagerDidSignInSuccessfully(_ facebookSignInManager: FacebookSignInManager) {
        print("successfully")
    }
}

// MARK: - GoogleSignInManagerDelegate
extension SignInViewController: GoogleSignInManagerDelegate {
    func googleSignInManagerDidSignInSuccessfully(_ googleSignInManager: GoogleSignInManager) {
        // route to Home
    }
}
