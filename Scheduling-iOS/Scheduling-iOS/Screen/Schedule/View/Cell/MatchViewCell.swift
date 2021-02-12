//
//  MatchViewCell.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 12/02/2021.
//

import Foundation
import UIKit

class MatchViewCell: UITableViewCell, MatchViewPresenter, Configurable {
    var dayLabel: UILabel! = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.label
        label.font = UIFont.boldSubText
        return label
    }()
    
    var leftNameLabel: UILabel! = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.label
        label.font = UIFont.body
        label.textAlignment = .right
        return label
    }()
    
    var vsImageView: UIImageView! = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Icon-match"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        return imageView
    }()
    
    var rightNameLabel: UILabel! = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.label
        label.font = UIFont.body
        label.textAlignment = .left
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
        contentView.addSubview(dayLabel)
        contentView.addSubview(leftNameLabel)
        contentView.addSubview(vsImageView)
        contentView.addSubview(rightNameLabel)
        contentView.backgroundColor = .clear
        constraintsInit()
    }
    
    private func constraintsInit() {
        NSLayoutConstraint.activate([
            // dayLabel
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CGFloat.defaultComponentsSpacing),
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: CGFloat.defaultSpacing),
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            dayLabel.bottomAnchor.constraint(equalTo: vsImageView.topAnchor, constant: -CGFloat.defaultComponentsSpacing),
            
            //vsImageView
            vsImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vsImageView.leftAnchor.constraint(equalTo: leftNameLabel.rightAnchor, constant: CGFloat.defaultSpacing),
            vsImageView.rightAnchor.constraint(equalTo: rightNameLabel.leftAnchor, constant: -CGFloat.defaultSpacing),
            vsImageView.heightAnchor.constraint(equalToConstant: CGFloat.defaultCellHeight),
            vsImageView.widthAnchor.constraint(equalToConstant: CGFloat.defaultCellHeight),
            vsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -CGFloat.defaultComponentsSpacing),
            
            //leftNameLabel
            leftNameLabel.centerYAnchor.constraint(equalTo: vsImageView.centerYAnchor),
            leftNameLabel.leadingAnchor.constraint(lessThanOrEqualTo: contentView.leadingAnchor, constant: CGFloat.defaultSpacing),
            
            //leftNameLabel
            rightNameLabel.centerYAnchor.constraint(equalTo: vsImageView.centerYAnchor),
            rightNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -CGFloat.defaultSpacing),
            
        ])
    }
    
    func configure(_ item: Any) {
        guard let vm = item as? MatchCellViewModel else { return }
        map(item: vm.match)
        dayLabel.text = vm.dayString
        contentView.backgroundColor = vm.isEvenIndex ? .evenCellBackground : .oddCellBackground
    }
}
