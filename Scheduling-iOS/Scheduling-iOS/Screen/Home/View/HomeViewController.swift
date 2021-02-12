//
//  HomeViewController.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation
import UIKit
import Combine

class HomeViewController: UIViewController, UIViewControllerConfigurable {
    
    var tableview: UITableView! = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = .clear
        return tableview
    }()
    
    var scheduleButton: UIButton! = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = CGFloat.defaultRadius
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldBody
        button.setTitle("Schedule", for: .normal)
        //button.backgroundColor = UIColor.assetColor(.navigationTitle)
        button.addTarget(self, action: #selector(scheduleButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private var viewModel: HomeViewModel!
    private var dataSource: HomeDataSource!
    private var bindings = Set<AnyCancellable>()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        constraintsInit()
        bindViewModel()
        updateUI()
    }
    
    func setupComponents() {
        view.backgroundColor = UIColor.primaryBackground
        view.addSubview(tableview)
        view.addSubview(scheduleButton)
        
        dataSource = HomeDataSource(delegate: viewModel)
        tableview.dataSource = dataSource
        tableview.delegate = dataSource
        tableview.register(TeamViewCell.self, forCellReuseIdentifier: TeamViewCell.typeName)
        tableview.register(PoolSectionView.self, forHeaderFooterViewReuseIdentifier: PoolSectionView.typeName)
    }
    
    
    func constraintsInit() {
        //Constraints
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat.defaultSpacing),
            tableview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.bottomAnchor.constraint(equalTo: scheduleButton.topAnchor, constant: CGFloat.defaultComponentsSpacing),
            scheduleButton.heightAnchor.constraint(equalToConstant: CGFloat.buttonHeight),
            scheduleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scheduleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.defaultSpacing),
            scheduleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: CGFloat.defaultSpacing)
        ])
    }
    
    
    func bindViewModel() {
        func bindViewModelToView() {
            let tableViewReloadHandler: (Bool) -> Void = { [weak self] _ in
                self?.tableview.reloadData()
            }
            
            let showAlertHandler: (String) -> Void = { [weak self] message in
                guard !message.isEmpty else { return }
                self?.showAlert(message: message)
            }

            viewModel.$reload
                .receive(on: RunLoop.main)
                .sink(receiveValue: tableViewReloadHandler)
                .store(in: &bindings)
            
            //Check Alert
            viewModel.$alertMessage
                .receive(on: RunLoop.main)
                .sink(receiveValue: showAlertHandler)
                .store(in: &bindings)
            
        }

        bindViewModelToView()
        
        viewModel.updatePools(size: 4, teamSize: 4)
    }
    
    func showAlert(message: String) {
        UIAlertController.presentOKAlert("Error", message: message)
    }
    
    func updateUI() {
    }
    
    @objc func scheduleButtonClicked() {
    }
}
