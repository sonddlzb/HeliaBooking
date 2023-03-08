//
//  SolarTextField.swift
//  Zip
//
//  Created by Linh Nguyen Duc on 23/06/2022.
//

import UIKit

@objc protocol SolarTextFieldDelegate: AnyObject {
    func solarTextField(_ textField: SolarTextField, willChangeToText text: String) -> Bool
    @objc optional func solarTextFieldShouldReturn(_ textField: SolarTextField) -> Bool
    @objc optional func solarTextField(addTextFieldChangedValueObserverTo textField: PaddingTextField)
    @objc optional func solarTextFieldDidChangeValue(_ textField: SolarTextField)
    @objc optional func solarTextFieldDidTapRightButton(_ textField: SolarTextField)
}

class SolarTextField: UIView {
    // MARK: - Public properties
    weak var delegate: SolarTextFieldDelegate?
    var isHighlightedWhenEditting = false
    var text: String {
        get {
            self.textField.text ?? ""
        }

        set {
            self.textField.text = newValue
        }
    }

    var placeholder: String? {
        didSet {
            self.textField.placeholder = placeholder
            self.didChangePlaceHolder()
        }
    }

    var attributedPlaceholder: NSAttributedString? {
        get {
            self.textField.attributedPlaceholder
        }

        set {
            self.textField.attributedPlaceholder = newValue
        }
    }

    var textAlignment: NSTextAlignment = .left {
        didSet {
            textField.textAlignment = textAlignment
        }
    }

    var paddingLeft = 0.0 {
        didSet {
            textField.paddingLeft = paddingLeft
        }
    }

    var isSecureText: Bool {
        get {
            self.textField.isSecureTextEntry
        }

        set {
            self.textField.isSecureTextEntry = newValue
            self.didSetSecureText()
        }
    }

    var isEditing: Bool {
        return self.textField.isEditing
    }

    var isRightButtonEnable = false {
        didSet {
            self.rightButton.isHidden = !self.isRightButtonEnable
        }
    }

    var rightTextFieldConstrant: NSLayoutConstraint!
    var rightButtonConstraint: NSLayoutConstraint!

    // MARK: - UI
    var textField = PaddingTextField()
    var rightButton = UIButton()

    // MARK: - Init
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    // MARK: - Common init
    func commonInit() {
        self.textField.enablesReturnKeyAutomatically = true
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
        self.rightTextFieldConstrant = self.textField.rightAnchor.constraint(equalTo: self.textField.superview!.rightAnchor)
        NSLayoutConstraint.activate([
            self.textField.leftAnchor.constraint(equalTo: self.textField.superview!.leftAnchor),
            self.textField.topAnchor.constraint(equalTo: self.textField.superview!.topAnchor),
            self.textField.bottomAnchor.constraint(equalTo: self.textField.superview!.bottomAnchor),
            self.rightTextFieldConstrant
        ])

        self.configTextField()
        self.configRightButton()

        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActiveNotitication(_:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    func configTextField() {
        textField.delegate = self
        textField.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        textField.tintColor = UIColor(rgb: 0x283244)
        textField.textAlignment = .left
        textField.keyboardType = .alphabet
        textField.returnKeyType = .done
        textField.attributedPlaceholder = self.attributedPlaceholder(for: self.textField.placeholder ?? "")
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    private func configRightButton() {
        self.rightButton.addTarget(self, action: #selector(rightViewDidTap), for: .touchUpInside)
        self.rightButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.rightButton)

        self.rightTextFieldConstrant.isActive = false
        self.rightButtonConstraint = self.rightButton.rightAnchor.constraint(equalTo: self.rightAnchor)
        NSLayoutConstraint.activate([
            self.rightButton.widthAnchor.constraint(equalToConstant: 30),
            self.rightButton.heightAnchor.constraint(equalToConstant: 30),
            self.rightButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.rightButton.leftAnchor.constraint(equalTo: self.textField.rightAnchor, constant: 5),
            self.rightButtonConstraint
        ])
        self.rightButton.isHidden = true

    }

    // MARK: - Action
    @objc private func rightViewDidTap() {
        self.handleRightButtonDidTap()
    }

    // MARK: - Dynamic function
    func didSetSecureText() {
        // subsclass will override
    }

    func didChangePlaceHolder() {
        // subsclass will override
    }

    // MARK: - Override
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        let becomeFirstResponder = super.becomeFirstResponder()
        return self.textField.becomeFirstResponder() || becomeFirstResponder
    }

    @discardableResult
    override func resignFirstResponder() -> Bool {
        let resignFirstResponder = super.resignFirstResponder()
        return self.textField.resignFirstResponder() || resignFirstResponder
    }

    // MARK: - Notification center
    @objc private func applicationDidBecomeActiveNotitication(_ notification: Notification) {
        if self.isEditing {
            self.becomeFirstResponder()
        }
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        self.delegate?.solarTextFieldDidChangeValue?(self)
    }

    // MARK: - Helper
    private func attributedPlaceholder(for text: String) -> NSAttributedString {
        return NSAttributedString(string: text, attributes: [
            .font: UIFont.systemFont(ofSize: 17, weight: .medium),
            .foregroundColor: UIColor(rgb: 0xCACACA)
        ])
    }

    func handleRightButtonDidTap() {
        self.delegate?.solarTextFieldDidTapRightButton?(self)
    }

    func setRightImage(image: UIImage?) {
        self.rightButton.setImage(image, for: .normal)
    }
}

// MARK: - UITextFieldDelegate
extension SolarTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (self.text as NSString).replacingCharacters(in: range, with: string)
        return self.delegate?.solarTextField(self, willChangeToText: text) ?? true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.delegate?.solarTextField?(addTextFieldChangedValueObserverTo: self.textField)
        if isHighlightedWhenEditting {
            self.borderWidth = 1
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if isHighlightedWhenEditting {
            self.borderWidth = 0
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.solarTextFieldShouldReturn?(self) ?? true
    }
}
