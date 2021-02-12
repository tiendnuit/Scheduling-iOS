//
//  UIAlertController+Utils.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation
import UIKit

//MARK: - UIAlertViewController
extension UIAlertController {
    
    static func okAlert(_ title: String, message: String?, okTapped: (()->Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            okTapped?()
        }))
        return alertController
    }
    
    static func presentOKAlert(_ title: String, message: String?, okTapped: (()->Void)? = nil) {
        let alertController = UIAlertController.okAlert(title, message: message, okTapped: okTapped)
        UIViewController.topMostController().present(alertController, animated: true, completion: nil)
    }
    
    static func presentInputAlert(_ title: String, message: String?, okTapped: ((String)->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = message
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            guard let textField = alert?.textFields?.first else {
                return
            }
            okTapped?(textField.text ?? "")
        }))

        UIViewController.topMostController().present(alert, animated: true, completion: nil)
    }
}
