//
//  SignInWithPassWordViewController.swift
//  HeliaHotelBooking
//
//  Created by Hà Quang Hưng on 07/03/2023.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

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
    
    private lazy var btnForgotThePassword: TapableView = {
        let tapableView = TapableView()
        let label = UILabel()
        label.text = "Forgot the password?"
        label.textAlignment = .center
        label.font = Outfit.regularFont(size: 17)
        label.textColor = R.color.crayola()
        tapableView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: tapableView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: tapableView.centerYAnchor).isActive = true
        tapableView.addTarget(self, action: #selector(didTapForgotThePassword(_:)), for: .touchUpInside)
        return tapableView
    }()

    private lazy var loginByPasswordView: LoginByPasswordView = {
        let loginByPasswordView = LoginByPasswordView()
        loginByPasswordView.delegate = self
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
        view.addSubview(btnForgotThePassword)
        signInByOtherView.delegate = self
    }

    private func addConstraintLayout() {
        signInByOtherView.translatesAutoresizingMaskIntoConstraints = false
        loginByPasswordView.translatesAutoresizingMaskIntoConstraints = false
        btnForgotThePassword.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInByOtherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signInByOtherView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signInByOtherView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            btnForgotThePassword.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            btnForgotThePassword.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            btnForgotThePassword.topAnchor.constraint(equalTo: loginByPasswordView.bottomAnchor, constant: 20.0),
            btnForgotThePassword.bottomAnchor.constraint(equalTo: signInByOtherView.topAnchor),
            btnForgotThePassword.heightAnchor.constraint(equalToConstant: 10.0),

            loginByPasswordView.topAnchor.constraint(lessThanOrEqualTo: btnPopScreen.bottomAnchor, constant: Const.bottomPadding),
            loginByPasswordView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginByPasswordView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    @IBAction func popScreenAction(_ sender: TapableView) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapForgotThePassword(_ sender: Any) {
        navigationController?.pushViewController(ForgotPasswordViewController(), animated: true)
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

extension SignInWithPassWordViewController: LoginByPasswordViewDelegate {
    func loginByPasswordViewDidTapConfirm(_ loginByPasswordView: LoginByPasswordView, email: String, password: String) {
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            SVProgressHUD.dismiss()
            guard let authResult = authResult, error == nil else {
                FailedDialog.show(title: "Failed to sign in", message: error?.localizedDescription ?? "Something went wrong!")
                return
            }

            print("Login successfully!")
            self?.navigationController?.pushViewController(HomeViewController(), animated: true)
        }

    }
}
