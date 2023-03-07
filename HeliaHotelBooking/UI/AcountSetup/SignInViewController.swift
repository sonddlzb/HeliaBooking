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

    @IBAction func popScreen(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func facebookLoginAction(_ sender: Any) {
        FacebookSignInManager.shared.delegate = self
        FacebookSignInManager.shared.signIn(withPresenting: self)
    }
    
    @IBAction func signInWithPasswordAction(_ sender: Any) {
    }
    
    
}

extension SignInViewController: FacebookSignInDelegate {
    func facebookSignInManagerDidSignInSuccessfully(_ facebookSignInManager: FacebookSignInManager) {
        //return home
        print("successfully")
    }
}
