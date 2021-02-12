//
//  Configurable.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation
protocol UIViewControllerConfigurable {
    func setupComponents()
    func bindViewModel()
    func updateUI()
}

protocol Configurable {
    func configure(_ item: Any)
}
