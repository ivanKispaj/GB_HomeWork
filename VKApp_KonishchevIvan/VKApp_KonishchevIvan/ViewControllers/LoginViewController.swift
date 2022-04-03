//
//  ViewController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 11.02.2022.
//

import UIKit

class LoginViewController: UIViewController {
    let colorDamage = UIColor(named: "AlarmColor")
    
    @IBOutlet weak var loadingView: LoadingView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
       // self.loadingView.isHidden = false
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
        let user =  UserData()
        let emailInput = self.emailTextField.text
        let passwordInput = self.passwordTextField.text
        if user.useremail == emailInput && user.userPassword == passwordInput {
        
         
           
            return true
        }
        if user.useremail != emailInput {
            let allert = AllertWrongUserData.getAllert(title: "Email", message: "Не верно введен email!")
            present(allert, animated: true, completion: nil)
            return false

        }
        let allert = AllertWrongUserData.getAllert(title: "Password", message: "Не верный пароль!")
        present(allert, animated: true, completion: nil)
       return false
    }
}

extension LoginViewController {

}

