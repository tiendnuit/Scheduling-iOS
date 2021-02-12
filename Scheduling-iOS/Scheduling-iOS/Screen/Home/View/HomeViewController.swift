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
    static let DEFAULT_POOL_SIZE = 4
    static let DEFAULT_TEAM_SIZE = 8
    var poolSizeLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.label
        label.font = UIFont.title
        label.text = "Pool's size: "
        label.numberOfLines = 1
        return label
    }()
    
    let poolSizeTextField: UITextField! = {
        let tf = UITextField()
        tf.textAlignment = .right
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "Input Pool's size"
        tf.text = "\(DEFAULT_POOL_SIZE)"
        return tf
    }()
    
    //Stackview
    let poolStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = CGFloat.defaultComponentsSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    var teamSizeLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.label
        label.font = UIFont.title
        label.text = "Team's size: "
        label.numberOfLines = 1
        return label
    }()
    
    let teamSizeTextField: UITextField! = {
        let tf = UITextField()
        tf.textAlignment = .right
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.borderStyle = .roundedRect
        tf.placeholder = "Input Team's size"
        tf.text = "\(DEFAULT_TEAM_SIZE)"
        return tf
    }()
    
    //Stackview
    let teamStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = CGFloat.defaultComponentsSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var setupButton: UIButton! = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = CGFloat.defaultRadius
        button.setTitleColor(UIColor.buttonTitle, for: .normal)
        button.titleLabel?.font = UIFont.boldBody
        button.setTitle("Setup", for: .normal)
        button.backgroundColor = UIColor.buttonBackground
        button.addTarget(self, action: #selector(setupButtonClicked), for: .touchUpInside)
        return button
    }()
    
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
        button.setTitleColor(UIColor.buttonTitle, for: .normal)
        button.titleLabel?.font = UIFont.boldBody
        button.setTitle("Schedule", for: .normal)
        button.backgroundColor = UIColor.buttonBackground
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
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponents()
        constraintsInit()
        bindViewModel()
        updateUI()
    }
    
    func setupComponents() {
        title = "Home"
        view.backgroundColor = UIColor.primaryBackground
        
        //add subviews
        poolStackView.addArrangedSubview(poolSizeLabel)
        poolStackView.addArrangedSubview(poolSizeTextField)
        
        //add subviews
        teamStackView.addArrangedSubview(teamSizeLabel)
        teamStackView.addArrangedSubview(teamSizeTextField)
        
        view.addSubview(poolStackView)
        view.addSubview(teamStackView)
        view.addSubview(setupButton)
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
            // Pool size
            poolStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat.defaultSpacing),
            poolStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            poolStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.defaultSpacing),
            poolStackView.heightAnchor.constraint(equalToConstant: CGFloat.topScheduleBarHeight),
            poolSizeTextField.widthAnchor.constraint(equalToConstant: CGFloat.defaultTextfieldWidth),
            
            // Team size
            teamStackView.topAnchor.constraint(equalTo: poolStackView.bottomAnchor, constant: CGFloat.defaultComponentsSpacing),
            teamStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            teamStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.defaultSpacing),
            teamStackView.heightAnchor.constraint(equalToConstant: CGFloat.topScheduleBarHeight),
            teamSizeTextField.widthAnchor.constraint(equalToConstant: CGFloat.defaultTextfieldWidth),
            
            //Setup button
            setupButton.topAnchor.constraint(equalTo: teamSizeTextField.bottomAnchor, constant: CGFloat.defaultSpacing),
            setupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            setupButton.heightAnchor.constraint(equalToConstant: CGFloat.buttonHeight),
            setupButton.widthAnchor.constraint(equalToConstant: CGFloat.defaultTextfieldWidth),
            
            // tableview
            tableview.topAnchor.constraint(equalTo: setupButton.bottomAnchor, constant: CGFloat.defaultSpacing),
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
            
            let showAlertHandler: (SchedulingError?) -> Void = { [weak self] error in
                guard let error = error else { return }
                self?.showAlert(message: error.message)
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
        
        viewModel.updatePools(size: HomeViewController.DEFAULT_POOL_SIZE,
                              teamSize: HomeViewController.DEFAULT_TEAM_SIZE)
    }
    
    func showAlert(message: String) {
        UIAlertController.presentOKAlert("Error", message: message)
    }
    
    func updateUI() {
    }
    
    @objc func scheduleButtonClicked() {
        viewModel.goToScheduleDetail()
    }
    
    @objc func setupButtonClicked() {
        poolSizeTextField.resignFirstResponder()
        teamSizeTextField.resignFirstResponder()
        guard let poolSize = Int(poolSizeTextField.text!),
              let teamSize = Int(teamSizeTextField.text!) else {
            return
        }
        viewModel.updatePools(size: poolSize, teamSize: teamSize)
    }
}
