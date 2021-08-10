//
//  Extensions+UITextFieldDelegate.swift
//  AisleConnectTest
//
//  Created by 黃昌齊 on 2021/8/4.
//

import Foundation
import UIKit

extension LoginViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
