//
//  SignUpViewController.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 08/03/2023.
//

import UIKit
import AVKit
import Photos
import DropDown

class SignUpViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var fullNameTextField: SolarTextField!
    @IBOutlet private weak var nicknameTextField: SolarTextField!
    @IBOutlet private weak var dateOfBirthTextField: SolarTextField!
    @IBOutlet private weak var phoneNumberTextField: SolarTextField!
    @IBOutlet private weak var genderTextField: SolarTextField!
    @IBOutlet private var avtImageView: UIImageView!
    @IBOutlet private var datePicker: UIDatePicker!
    @IBOutlet private weak var datePickerContainerView: UIView!

    // MARK: - Variables
    private var imagePicker = UIImagePickerController()
    private var currentDate = Date()
    private var dropDown = DropDown()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.config()
    }

    // MARK: - Config
    private func config() {
        fullNameTextField.placeholder = "Full Name"
        fullNameTextField.isHighlightedWhenEditting = true
        fullNameTextField.backgroundColor = R.color.lotion()
        fullNameTextField.borderColor = R.color.crayola()
        fullNameTextField.textField.paddingLeft = 10
        fullNameTextField.cornerRadius = 12
        fullNameTextField.delegate = self
        self.becomeFirstResponder()

        nicknameTextField.placeholder = "Nickname"
        nicknameTextField.isHighlightedWhenEditting = true
        nicknameTextField.backgroundColor = R.color.lotion()
        nicknameTextField.borderColor = R.color.crayola()
        nicknameTextField.textField.paddingLeft = 10
        nicknameTextField.cornerRadius = 12
        nicknameTextField.delegate = self

        dateOfBirthTextField.placeholder = "Date of Birth"
        dateOfBirthTextField.isHighlightedWhenEditting = true
        dateOfBirthTextField.backgroundColor = R.color.lotion()
        dateOfBirthTextField.borderColor = R.color.crayola()
        dateOfBirthTextField.textField.paddingLeft = 10
        dateOfBirthTextField.cornerRadius = 12
        dateOfBirthTextField.delegate = self
        dateOfBirthTextField.isRightButtonEnable = true
        dateOfBirthTextField.setRightImage(image: R.image.ic_calendar())

        phoneNumberTextField.placeholder = "Phone Number"
        phoneNumberTextField.isHighlightedWhenEditting = true
        phoneNumberTextField.backgroundColor = R.color.lotion()
        phoneNumberTextField.borderColor = R.color.crayola()
        phoneNumberTextField.textField.paddingLeft = 10
        phoneNumberTextField.cornerRadius = 12
        phoneNumberTextField.delegate = self

        genderTextField.placeholder = "Gender"
        genderTextField.isHighlightedWhenEditting = true
        genderTextField.backgroundColor = R.color.lotion()
        genderTextField.borderColor = R.color.crayola()
        genderTextField.textField.paddingLeft = 10
        genderTextField.cornerRadius = 12
        genderTextField.delegate = self
        genderTextField.isRightButtonEnable = true
        genderTextField.setRightImage(image: R.image.ic_arrow_down())

        self.imagePicker.delegate = self
        self.datePicker.maximumDate = Date()
    }

    @IBAction func didTapToChangeAvatar(_ sender: TapableView) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.openCamera()
            }))

            alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                self.openGallary()
            }))

            alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }

    func openCamera() {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                PermissionHelper().requestCameraPermission(mediaType: .video) { granted, needOpenSetting in
                    if granted {
                        DispatchQueue.main.async {
                            self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                            self.imagePicker.allowsEditing = true
                            self.present(self.imagePicker, animated: true, completion: nil)
                        }
                    } else if needOpenSetting {
                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(settingsURL)
                        }
                    }
                }
            } else {
                let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
    }

    func openGallary() {
        PermissionHelper().requestPhotoPermission { granted, needOpenSetting in
            if granted {
                DispatchQueue.main.async {
                    self.imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                    self.imagePicker.allowsEditing = true
                    self.present(self.imagePicker, animated: true, completion: nil)
                }
            } else if needOpenSetting {
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }
        }

    }

    private func showDatePicker() {
        self.datePicker.alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.datePickerContainerView.backgroundColor = .white
            self.datePickerContainerView.isUserInteractionEnabled = true
            self.datePicker.alpha = 1
        }

        self.datePicker.isHidden = false
    }

    private func hideDatePicker() {
        self.datePicker.alpha = 1
        UIView.animate(withDuration: 0.25) {
            self.datePickerContainerView.backgroundColor = .clear
            self.datePickerContainerView.isUserInteractionEnabled = false
            self.datePicker.alpha = 0
        }

        self.datePicker.isHidden = true
    }

    private func showDropDownMenu() {
        dropDown.dataSource = Gender.listGenders()
        dropDown.anchorView = self.genderTextField
        dropDown.bottomOffset = CGPoint(x: 0, y: genderTextField.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = { [weak self] (_, item) in
            guard self != nil else { return }
            self?.genderTextField.text = item
        }
    }

    @IBAction func didTapBackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func didChangeCalendarValue(_ sender: Any) {
        self.currentDate = datePicker.date
        self.dateOfBirthTextField.text = self.currentDate.formatDate()
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.avtImageView.image = pickedImage
        }

        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - SolarTextFieldDelegate
extension SignUpViewController: SolarTextFieldDelegate {
    func solarTextField(_ textField: SolarTextField, willChangeToText text: String) -> Bool {
        return true
    }

    func solarTextFieldDidTapRightButton(_ textField: SolarTextField) {
        if textField == self.dateOfBirthTextField {
            self.showDatePicker()
        } else if textField == self.genderTextField {
            self.showDropDownMenu()
        }
    }
}

extension SignUpViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == self.view {
            self.hideDatePicker()
        }
    }
}