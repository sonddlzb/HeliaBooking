//
//  SignInWithPassWordViewController.swift
//  HeliaHotelBooking
//
//  Created by Hà Quang Hưng on 07/03/2023.
//

import UIKit

private struct Const {
    static let leftPadding = 12.0
    static let rightPadding = -50.0
    static let bottomPadding = 50.0
    static let height = 300.0
}

class SignInWithPassWordViewController: UIViewController {
    
    
    @IBOutlet private weak var btnPopScreen: TapableView!
    
    private lazy var signInByOtherView: SignInByOtherView = {
        guard let signInByOtherView = SignInByOtherView.loadView(fromNib: "SignInByOtherView") else {
            let signInByOtherView = SignInByOtherView()
            return signInByOtherView
        }
            return signInByOtherView
    }()
    
    private lazy var loginByPasswordView: LoginByPasswordView = {
        let loginByPasswordView = LoginByPasswordView()
        return loginByPasswordView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    func setUpView() {
        addContentView()
        addConstraintLayout()
    }
    
    private func addContentView() {
        view.addSubview(signInByOtherView)
        view.addSubview(loginByPasswordView)
        signInByOtherView.delegate = self
    }
    
    private func addConstraintLayout() {
        signInByOtherView.translatesAutoresizingMaskIntoConstraints = false
        loginByPasswordView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInByOtherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signInByOtherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signInByOtherView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loginByPasswordView.topAnchor.constraint(lessThanOrEqualTo: btnPopScreen.bottomAnchor, constant: Const.bottomPadding),
            loginByPasswordView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginByPasswordView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginByPasswordView.bottomAnchor.constraint(equalTo: signInByOtherView.topAnchor)
        ])
    }

    
    
    @IBAction func popScreenAction(_ sender: TapableView) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension SignInWithPassWordViewController: SignInByOtherViewDelegate {
    func signInByOtherViewDidTapSignInFacebook(_ signInByOtherView: SignInByOtherView) {
        FacebookSignInManager.shared.delegate = self
        FacebookSignInManager.shared.signIn(withPresenting: self)
    }
    
    func signInByOtherViewDidTapSignInGoogle(_ signInByOtherView: SignInByOtherView) {
        GoogleSignInManager.shared.delegate = self
        GoogleSignInManager.shared.signIn(withPresenting: self)
    }
    
}

extension SignInWithPassWordViewController: FacebookSignInDelegate {
    func facebookSignInManagerDidSignInSuccessfully(_ facebookSignInManager: FacebookSignInManager) {
        print("sucessfully")
    }


}

extension SignInWithPassWordViewController: GoogleSignInManagerDelegate {
    func googleSignInManagerDidSignInSuccessfully(_ googleSignInManager: GoogleSignInManager) {
        print("sucessfully")
    }


}
