//
//  InsertCodeViewController.swift
//  HeliaHotelBooking
//
//  Created by Hà Quang Hưng on 09/03/2023.
//

import UIKit

class InsertCodeViewController: UIViewController {
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var textField4: UITextField!
    @IBOutlet weak var labelPhoneNumber: UILabel!
    @IBOutlet weak var labelCountingTime: UILabel!
    
    
    private var textField1IsEditing = false
    private var textField2IsEditing = false
    private var textField3IsEditing = false
    private var textField4IsEditing = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        textField4.delegate = self
        textField1.becomeFirstResponder()
    }
    
    
    @IBAction func btnPopScreenDidTap(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnVerifyDidTap(_ sender: Any) {
        //verify code
    }
    
    
}

extension InsertCodeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 1
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)
    
        return newString.count <= maxLength
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if self.textField1.text?.count == 1 {
            self.textField2.becomeFirstResponder()
            textField1IsEditing = true
        }
        if self.textField2.text?.count == 1 {
            self.textField3.becomeFirstResponder()
            self.textField2IsEditing = true
        }
        if self.textField3.text?.count == 1 {
            textField4.becomeFirstResponder()
            textField3IsEditing = true
        }
        if self.textField4.text?.count == 1 {
            textField4IsEditing = true
            self.view.endEditing(true)
        }
        if textField4IsEditing == true && textField4.text?.count == 0 {
            textField3.becomeFirstResponder()
            textField4IsEditing = false
        }
        if textField3IsEditing == true && textField3.text?.count == 0 {
            textField2.becomeFirstResponder()
            textField3IsEditing = false
        }
        if textField2IsEditing == true && textField2.text?.count == 0 {
            textField1.becomeFirstResponder()
            textField2IsEditing = false
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.borderColor = R.color.crayola()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.borderColor = R.color.lightGray()
        return true
    }
    
}

