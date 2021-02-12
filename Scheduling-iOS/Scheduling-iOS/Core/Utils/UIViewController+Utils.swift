//
//  UIViewController+Utils.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation
import UIKit

extension UIViewController {

    @IBAction func closeTapped() {
        dismiss()
    }
    
    @IBAction func leftButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func addCloseButton(with title:String = "Cancel") {
        let closeButtonItem = UIBarButtonItem(title: title,
                                              style: .plain,
                                              target: self,
                                              action: #selector(UIViewController.closeTapped))
        navigationItem.leftBarButtonItem = closeButtonItem
    }
    
    @objc func dismiss() {
        if let nc = navigationController, nc.viewControllers.count > 1 {
            nc.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func show(viewController: UIViewController) {
        if let nc = navigationController {
            nc.pushViewController(viewController, animated: true)
        } else {
            presentModally(viewController: viewController)
        }
    }
    
    func presentModally(viewController: UIViewController, closeEnable: Bool = false) {
        if closeEnable {
            viewController.addCloseButton(with: "Close")
        }
        
        let nc = UINavigationController(rootViewController: viewController)
        present(nc, animated: true, completion: nil)
    }
    
    static func topMostController() -> UIViewController {
        
        let delegate = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.delegate as? SceneDelegate
        var topController: UIViewController = delegate!.window!.rootViewController!
        for _ in 0..<2 {
            while topController.presentedViewController != nil && topController.presentedViewController?.isKind(of: UIAlertController.self) == false {
                topController = topController.presentedViewController!
            }
            if (topController.isKind(of: UITabBarController.self)) {
                topController = ((topController as! UITabBarController)).selectedViewController!
            }
            if (topController.isKind(of: UINavigationController.self)) {
                topController = ((topController as! UINavigationController)).topViewController!
            }
        }
        return topController
    }
    
    static func rootViewController() -> UIViewController? {
        let delegate = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.delegate as? SceneDelegate
        return delegate!.window?.rootViewController
    }
    
}
