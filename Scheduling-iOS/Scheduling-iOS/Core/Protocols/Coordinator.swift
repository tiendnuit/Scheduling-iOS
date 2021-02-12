//
//  Coordinator.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
