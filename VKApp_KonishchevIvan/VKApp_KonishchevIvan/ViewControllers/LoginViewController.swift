//
//  ViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 11.02.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
   
    @IBOutlet weak var emailLable: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordLable: UILabel!
    @IBOutlet weak var passwordHelper: UILabel!
    
    @IBOutlet weak var enterButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.addTarget(self, action: #selector(emailFieldDidChangeSelection(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordFieldDidChsngeSelection(_:)), for: .editingChanged)
        
        let tapScreen = UITapGestureRecognizer(target: self, action: #selector( hideKeyboard ))
        view.addGestureRecognizer( tapScreen )
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector( willShowKayboard ), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector( willHideKeyboard ), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let user =  UserDetail()
        let emailInput = self.emailTextField.text
        let passwordInput = self.passwordTextField.text
        if user.useremail == emailInput && user.userPassword == passwordInput {
            return true
        }
        let allert = AllertWrongUserData.getAllert(title: "Error", message: "Не верные данные пользователя!")
        present(allert, animated: true, completion: nil)
       return false
    }

        
    
}



