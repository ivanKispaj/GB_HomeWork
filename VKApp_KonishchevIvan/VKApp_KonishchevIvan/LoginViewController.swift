//
//  ViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 11.02.2022.
//

import UIKit

class LoginViewController: UIViewController {


    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var passwordHelper: UILabel!
   
    @IBAction func enterButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextfield.addTarget(self, action: #selector(emailFieldDidChangeSelection(_:)), for: .editingChanged)
        passwordTextfield.addTarget(self, action: #selector(passwordFieldDidChsngeSelection(_:)), for: .editingChanged)
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let user =  UserDetail()
        let emailInput = self.emailTextfield.text
        let passwordInput = self.passwordTextfield.text
        if user.useremail == emailInput && user.userPassword == passwordInput {
           
            return true
        }
        let allert = UIAlertController(title: "Error", message: "Введены неверные данные пользователя! Попробуйте снова.", preferredStyle: .alert)
        let allertAction = UIAlertAction(title: "ОК", style: .cancel, handler: nil)
        allert.addAction(allertAction)
        present(allert, animated: true, completion: nil)
       return false
    }

    
}


// MARK: - Verification textFields

extension LoginViewController {
    
    @objc func passwordFieldDidChsngeSelection(_ textfield: UITextField){
  
        guard Validators.issimplePass( passwordTextfield.text! ) else {
            self.passwordLabel.backgroundColor = .red
            self.passwordHelper.backgroundColor = .red
            self.passwordHelper.text = " Мин. 8 символов, заглавная буква и цифра! "
            return
        }
        self.passwordLabel.backgroundColor = .white
        self.passwordHelper.text = ""
    }
    
    @objc private func emailFieldDidChangeSelection(_ textfield: UITextField){
        guard Validators.isSimpleEmail(emailTextfield.text!) else {
            self.emailLabel.backgroundColor = .red
            return
        }
        self.emailLabel.backgroundColor = .white
    }
    
}
