//
//  UIViewController+Extension.swift
//  SecureApp
//
//  Created by Simone Testa on 18/02/22.
//

import Foundation
import UIKit

extension UIViewController {
    func dismissKeyboardOnViewTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
