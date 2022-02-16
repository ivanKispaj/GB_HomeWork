//
//  Extension_LoginController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 15.02.2022.
//

import UIKit

// MARK: - hideKeyboard
extension LoginViewController {
    @objc func hideKeyboard() {
        view.endEditing( true )
    }
}

// MARK: - Verification textFields

extension LoginViewController {
    
    @objc func passwordFieldDidChsngeSelection(_ textfield: UITextField){
  
        guard Validators.issimplePass( passwordTextField.text! ) else {
            self.passwordLable.backgroundColor = .red
            self.passwordHelper.backgroundColor = .red
            self.passwordHelper.text = " Мин. 8 символов, заглавная буква и цифра! "
            return
        }
        self.passwordLable.backgroundColor = .white
        self.passwordHelper.text = ""
    }
    
    @objc  func emailFieldDidChangeSelection(_ textfield: UITextField){
        guard Validators.isSimpleEmail(emailTextField.text!) else {
            self.emailLable.backgroundColor = .red
            return
        }
        self.emailLable.backgroundColor = .white
    }
    
    @objc func willShowKayboard(_ notification: Notification) {
        guard let info = notification.userInfo as NSDictionary?,
              let keyboardSize = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else { return }
        let keyboardHight = keyboardSize.cgRectValue.size.height
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHight, right: 0)
    }
    
    @objc func willHideKeyboard(_ notification: Notification){
        guard let info = notification.userInfo as NSDictionary?,
              let keyboardSize = info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as? NSValue else { return }
        let keyboardHight = keyboardSize.cgRectValue.size.height
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -keyboardHight, right: 0)
    }
    
}

