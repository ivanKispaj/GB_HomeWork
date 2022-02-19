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
            self.passwordTextField.backgroundColor = colorDamage
            return
        }
        self.passwordTextField.backgroundColor = .white
    }
    
    @objc  func emailFieldDidChangeSelection(_ textfield: UITextField){
        guard Validators.isSimpleEmail(emailTextField.text!) else {
            self.emailTextField.backgroundColor = colorDamage
            return
        }
        self.emailTextField.backgroundColor = .white
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

