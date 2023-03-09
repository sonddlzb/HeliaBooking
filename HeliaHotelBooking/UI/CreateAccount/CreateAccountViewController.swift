//
//  CreateAccountViewController.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 09/03/2023.
//

import UIKit

private struct Const {
    static let leftPadding = 12.0
    static let rightPadding = -50.0
    static let bottomPadding = 50.0
    static let height = 300.0
}

class CreateAccountViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var backButton: TapableView!

    private lazy var signInByOtherView: SignInByOtherView = {
        guard let signInByOtherView = SignInByOtherView.loadView(fromNib: "SignInByOtherView") else {
            let signInByOtherView = SignInByOtherView()
            return signInByOtherView
        }
            return signInByOtherView
    }()

    private lazy var loginByPasswordView: LoginByPasswordView = {
        let loginByPasswordView = LoginByPasswordView()
        loginByPasswordView.bindData(title: "Create your Account", confirmContent: "Sign up")
        loginByPasswordView.delegate = self
        return loginByPasswordView
    }()

    // MARK: - Lifecycle
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

            loginByPasswordView.topAnchor.constraint(lessThanOrEqualTo: backButton.bottomAnchor, constant: Const.bottomPadding),
            loginByPasswordView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginByPasswordView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginByPasswordView.bottomAnchor.constraint(equalTo: signInByOtherView.topAnchor)
        ])
    }

    // MARK: - Actions
    @IBAction func backButtonDidTap(_ sender: TapableView) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - SignInByOtherViewDelegate
extension CreateAccountViewController: SignInByOtherViewDelegate {
    func signInByOtherViewDidTapSignInFacebook(_ signInByOtherView: SignInByOtherView) {
        FacebookSignInManager.shared.delegate = self
        FacebookSignInManager.shared.signIn(withPresenting: self)
    }

    func signInByOtherViewDidTapSignInGoogle(_ signInByOtherView: SignInByOtherView) {
        GoogleSignInManager.shared.delegate = self
        GoogleSignInManager.shared.signIn(withPresenting: self)
    }

}

// MARK: - FacebookSignInDelegate
extension CreateAccountViewController: FacebookSignInDelegate {
    func facebookSignInManagerDidSignInSuccessfully(_ facebookSignInManager: FacebookSignInManager) {
        print("sucessfully")
    }
}

// MARK: - GoogleSignInManagerDelegate
extension CreateAccountViewController: GoogleSignInManagerDelegate {
    func googleSignInManagerDidSignInSuccessfully(_ googleSignInManager: GoogleSignInManager) {
        print("sucessfully")
    }
}

// MARK: - LoginByPasswordViewDelegate
extension CreateAccountViewController: LoginByPasswordViewDelegate {
    func loginByPasswordViewDidTapConfirm(_ loginByPasswordView: LoginByPasswordView, email: String, password: String) {
        let signUpViewController = SignUpViewController(email: email, password: password)
        self.navigationController?.pushViewController(signUpViewController, animated: true)
    }
}
