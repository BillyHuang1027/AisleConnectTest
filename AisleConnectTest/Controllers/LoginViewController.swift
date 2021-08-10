//
//  LoginViewController.swift
//  AisleConnectTest
//
//  Created by 黃昌齊 on 2021/8/4.
//

import UIKit

class LoginViewController: UIViewController {
    
    let user = "paul.lin@lineagenetworks.com"
    let pass = "welcome1"
    var accessToken: String?
    
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blackColor: UIColor = UIColor.black
        accountTextField.layer.borderColor = blackColor.cgColor
        accountTextField.layer.borderWidth = 1
        accountTextField.delegate = self
        passwordTextField.layer.borderColor = blackColor.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.delegate = self
    }
    
    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func login(_ sender: Any) {
        let username = accountTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        if username.isEmpty == true || password.isEmpty == true {
            showAlert(message: "Do not leave blank.")
        } else {
            if username != user || password != pass {
                showAlert(message: "Wrong username or password.")
            } else {
                ConnectController.shared.retrieveToken(username: username, password: password) { (result) in
                    switch result {
                    
                    case .success(let accessToken):
                        self.accessToken = accessToken.access_token
                        print(self.accessToken)
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "ToListPage", sender: sender)
                        }
                    case .failure(let error):
                        self.showAlert(message: "Wrong username or password.")
                    }
                }
            }
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Log in fail!", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? ListTableViewController {
            controller.accessToken = accessToken!
        }
    }
    

}
