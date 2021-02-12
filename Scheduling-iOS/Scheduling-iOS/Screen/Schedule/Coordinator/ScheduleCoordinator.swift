//
//  ScheduleCoordinator.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 12/02/2021.
//

import Foundation
import UIKit
import Combine

protocol ScheduleCoordinatorDelegate: class {
    func requestDismissal()
}

class ScheduleCoordinator: Coordinator {
    var navigationController: UINavigationController
    private var bindings = Set<AnyCancellable>()
    private var pools: [Pool]!
    weak var coordinatorDelegate: ScheduleCoordinatorDelegate?

    init(navigationController: UINavigationController, pools: [Pool]) {
        self.navigationController = navigationController
        self.pools = pools
    }
    
    func start() {
        let viewModel = ScheduleViewModel(pools: pools)
        viewModel.$dismissed
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] dismissed in
                if dismissed {
                    self?.coordinatorDelegate?.requestDismissal()
                }
            })
            .store(in: &bindings)
        
        let vc = ScheduleDetailViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: true)
    }
}
