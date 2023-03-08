//
//  SignInByOtherView.swift
//  HeliaHotelBooking
//
//  Created by Hà Quang Hưng on 08/03/2023.
//

import UIKit

protocol SignInByOtherViewDelegate: AnyObject {
    func signInByOtherViewDidTapSignInFacebook(_ signInByOtherView: SignInByOtherView)
    func signInByOtherViewDidTapSignInGoogle(_ signInByOtherView: SignInByOtherView)
}

class SignInByOtherView: UIView {
    weak var delegate: SignInByOtherViewDelegate?
    
    @IBAction func signInFacebookBtnDidTap(_ sender: TapableView) {
        self.delegate?.signInByOtherViewDidTapSignInFacebook(self)
    }
    
    @IBAction func signInGoogleBtnDidTap(_ sender: TapableView) {
        self.delegate?.signInByOtherViewDidTapSignInGoogle(self)
    }
    
    @IBAction func signInAppleBtnDidTap(_ sender: TapableView) {
    }
    
}
