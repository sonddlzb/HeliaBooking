//
//  ConfirmDialogView.swift
//  TestCustomView
//
//  Created by đào sơn on 02/03/2023.
//

import UIKit

protocol ConfirmDialogViewDelegate: AnyObject {
    func confirmDialogViewDidTapYes(_ confirmDialogView: ConfirmDialogView)
    func confirmDialogViewDidTapCancel(_ confirmDialogView: ConfirmDialogView)
}

class ConfirmDialogView: UIView {

    // MARK: - Outlets
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var yesButton: TapableView!
    @IBOutlet private weak var cancelButton: TapableView!
    @IBOutlet private weak var backgroundView: UIView!

    // MARK: - Variables
    weak var delegate: ConfirmDialogViewDelegate?

    // MARK: -Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        self.containerView.layer.cornerRadius = 20
        self.cancelButton.cornerRadius = 24
        self.yesButton.cornerRadius = 24
    }

    static func loadView() -> ConfirmDialogView {
        return ConfirmDialogView.loadView(fromNib: "ConfirmDialogView")!
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

    @IBAction func yesButtonDidTap(_ sender: TapableView) {
        self.delegate?.confirmDialogViewDidTapYes(self)
        self.dismiss()
    }

    @IBAction func cancelButtonDidTap(_ sender: TapableView) {
        self.delegate?.confirmDialogViewDidTapCancel(self)
        self.dismiss()
    }

}
