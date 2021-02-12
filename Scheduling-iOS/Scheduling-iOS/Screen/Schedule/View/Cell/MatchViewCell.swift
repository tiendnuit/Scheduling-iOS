//
//  MatchViewCell.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 12/02/2021.
//

import Foundation
import UIKit

class MatchViewCell: UITableViewCell, MatchViewPresenter, Configurable {
    var nameLabel: UILabel! = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.label
        label.font = UIFont.body
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupComponents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupComponents() {
        contentView.addSubview(nameLabel)
        contentView.backgroundColor = .clear
        constraintsInit()
    }
    
    private func constraintsInit() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat.defaultSpacing),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    func configure(_ item: Any) {
        guard let vm = item as? MatchCellViewModel else { return }
        //map(item: vm.match)
        nameLabel.text = vm.matchString
    }
}
