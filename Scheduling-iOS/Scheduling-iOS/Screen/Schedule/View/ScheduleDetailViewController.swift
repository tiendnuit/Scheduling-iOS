//
//  ScheduleDetailViewController.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation
import UIKit
import Combine

class ScheduleDetailViewController: UIViewController, UIViewControllerConfigurable {
    
    var tableview: UITableView! = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.backgroundColor = .clear
        return tableview
    }()
    
    var preButton: UIButton! = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = CGFloat.defaultRadius
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.title
        button.setTitle("<", for: .normal)
        button.backgroundColor = UIColor.buttonBackground
        button.addTarget(self, action: #selector(preButtonClicked), for: .touchUpInside)
        return button
    }()
    
    var titleLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.label
        label.font = UIFont.title
        label.text = "Week 1"
        label.numberOfLines = 1
        return label
    }()
    
    var nextButton: UIButton! = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = CGFloat.defaultRadius
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.title
        button.setTitle(">", for: .normal)
        button.backgroundColor = UIColor.buttonBackground
        button.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        return button
    }()
    
    //Stackview
    let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = CGFloat.defaultComponentsSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var viewModel: ScheduleViewModel!
    private var dataSource: MatchDataSource!
    private var bindings = Set<AnyCancellable>()
    
    init(viewModel: ScheduleViewModel) {
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
        title = "Schedule"
        view.backgroundColor = UIColor.primaryBackground
        topStackView.addArrangedSubview(preButton)
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(nextButton)
        view.addSubview(topStackView)
        view.addSubview(tableview)
        
        dataSource = MatchDataSource(delegate: viewModel)
        tableview.dataSource = dataSource
        tableview.delegate = dataSource
        tableview.register(MatchViewCell.self, forCellReuseIdentifier: MatchViewCell.typeName)
        
        addCloseButton(with: "Back")
    }
    
    
    func constraintsInit() {
        //Constraints
        NSLayoutConstraint.activate([
            //topStackView
            topStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat.defaultSpacing),
            topStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topStackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: CGFloat.defaultSpacing),
            topStackView.heightAnchor.constraint(equalToConstant: CGFloat.topScheduleBarHeight),
            topStackView.bottomAnchor.constraint(equalTo: tableview.topAnchor, constant: -CGFloat.defaultComponentsSpacing),
            preButton.widthAnchor.constraint(equalToConstant: CGFloat.defaultButtonWidth),
            nextButton.widthAnchor.constraint(equalToConstant: CGFloat.defaultButtonWidth),
            
            //tableview
            tableview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: CGFloat.defaultSpacing),
        ])
    }
    
    override func closeTapped() {
        viewModel.dismiss()
    }
    
    func bindViewModel() {
        func bindViewModelToView() {
            let tableViewReloadHandler: (Bool) -> Void = { [weak self] _ in
                self?.tableview.reloadData()
            }
            
            viewModel.$reload
                .receive(on: RunLoop.main)
                .sink(receiveValue: tableViewReloadHandler)
                .store(in: &bindings)
            
            viewModel.$preable
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] able in
                    self?.preButton.isEnabled = able
                    self?.preButton.alpha = able ? 1 : 0.5
                })
                .store(in: &bindings)
            
            viewModel.$nextable
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] able in
                    self?.nextButton.isEnabled = able
                    self?.nextButton.alpha = able ? 1 : 0.5
                })
                .store(in: &bindings)
            
            viewModel.$currentWeek
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] current in
                    self?.titleLabel.text = "Week \(current)"
                    self?.tableview.reloadData()
                })
                .store(in: &bindings)
        }

        bindViewModelToView()
    }
    
    
    func updateUI() {
    }
    
    @objc func preButtonClicked() {
        viewModel.goBack()
    }
    
    @objc func nextButtonClicked() {
        viewModel.goNext()
    }
}
