//
//  PoolSectionView.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation
import UIKit

final class PoolSectionView: UITableViewHeaderFooterView {
    var titleLabel: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.label
        label.font = UIFont.title
        label.numberOfLines = 1
        return label
    }()
    
    var editButton: UIButton! = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = CGFloat.defaultRadius
        button.setTitleColor(UIColor.buttonTitle, for: .normal)
        button.titleLabel?.font = UIFont.boldBody
        button.setImage(#imageLiteral(resourceName: "icon-edit"), for: .normal)
        button.backgroundColor = UIColor.clear
        button.addTarget(self, action: #selector(editButtonClicked), for: .touchUpInside)
        return button
    }()
    
    var expandedButton: UIButton! = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = CGFloat.defaultRadius
        button.setTitleColor(UIColor.buttonTitle, for: .normal)
        button.titleLabel?.font = UIFont.boldBody
        button.setTitle("Ex", for: .normal)
        button.backgroundColor = UIColor.buttonBackground
        button.addTarget(self, action: #selector(expandeButtonClicked), for: .touchUpInside)
        return button
    }()
    
    var editPoolNameClosure: ((String) -> ())?
    var expandeActionClosure: (() -> ())?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupComponents()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupComponents() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(expandedButton)
        
        contentView.backgroundColor = .secondaryBackground
        constraintsInit()
    }
    
    private func constraintsInit() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CGFloat.defaultComponentsSpacing),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat.defaultSpacing),
            titleLabel.rightAnchor.constraint(equalTo: editButton.leftAnchor, constant: CGFloat.defaultComponentsSpacing),
            editButton.heightAnchor.constraint(equalToConstant: CGFloat.smallButtonHeight),
            editButton.widthAnchor.constraint(equalToConstant: CGFloat.smallButtonHeight),
            editButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            editButton.rightAnchor.constraint(equalTo: expandedButton.leftAnchor, constant: -CGFloat.defaultComponentsSpacing),
            expandedButton.heightAnchor.constraint(equalToConstant: CGFloat.smallButtonHeight),
            expandedButton.widthAnchor.constraint(equalToConstant: CGFloat.smallButtonHeight),
            expandedButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            expandedButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -CGFloat.defaultSpacing)
        ])
    }
    
    @objc private func editButtonClicked() {
        UIAlertController.presentInputAlert("Edit Pool's Name", message: titleLabel.text) { [weak self] (name) in
            guard name != self?.titleLabel.text else { return }
            self?.editPoolNameClosure?(name)
        }
    }
    
    @objc private func expandeButtonClicked() {
        expandeActionClosure?()
    }
}
