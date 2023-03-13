//
//  PaymentNotificationDialogView.swift
//  TestCustomView
//
//  Created by đào sơn on 02/03/2023.
//

import UIKit

protocol PaymentNotificationDialogViewDelegate: AnyObject {
    func paymentNotificationDialogViewDidTapViewTicket(_ paymentNotificationDialogView: PaymentNotificationDialogView)
    func paymentNotificationDialogViewDidTapCancel(_ paymentNotificationDialogView: PaymentNotificationDialogView)
}

class PaymentNotificationDialogView: UIView {

    // MARK: - Outlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var backgroundView: UIView!

    // MARK: - Variables
    weak var delegate: PaymentNotificationDialogViewDelegate?

    static func loadView() -> PaymentNotificationDialogView {
        return PaymentNotificationDialogView.loadView(fromNib: "PaymentNotificationDialogView") ?? PaymentNotificationDialogView()
    }

    // MARK: - Public method
    func show(in view: UIView) {
        self.alpha = 0
        view.addSubview(self)
        self.fitSuperviewConstraint()
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }

    func dismiss() {
        UIView.animate(withDuration: 0.25) {
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }

    // MARK: - Touches began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if touches.first?.view == self.backgroundView {
            self.dismiss()
        }
    }

    @IBAction func viewTicketButtonDidTap(_ sender: TapableView) {
        self.delegate?.paymentNotificationDialogViewDidTapViewTicket(self)
        self.dismiss()
    }

    @IBAction func cancelButtonDidTap(_ sender: TapableView) {
        self.delegate?.paymentNotificationDialogViewDidTapCancel(self)
        self.dismiss()
    }

}
