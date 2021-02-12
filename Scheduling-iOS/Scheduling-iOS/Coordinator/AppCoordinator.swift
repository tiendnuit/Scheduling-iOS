//
//  AppCoordinator.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation
import UIKit
import Combine

class AppCoordinator: Coordinator {
    private var window: UIWindow?
    private var homeViewModel: HomeViewModel?
    
    var navigationController = UINavigationController()
    var childCoordinator: Coordinator? = nil
    private var bindings = Set<AnyCancellable>()
    
    init(_ window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        showHomePage()
    }
    
    func showHomePage() {
        let viewModel = HomeViewModel()
        let homePage = HomeViewController(viewModel: viewModel)
        homeViewModel = viewModel
        navigationController.viewControllers = [homePage]
    }
    
    
}
