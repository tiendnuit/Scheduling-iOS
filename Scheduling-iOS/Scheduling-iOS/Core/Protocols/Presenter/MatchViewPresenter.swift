//
//  MatchViewPresenter.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 12/02/2021.
//

import Foundation
import UIKit

protocol MatchViewPresenter {
    var dayLabel: UILabel! {set get}
    var leftNameLabel: UILabel! {set get}
    var vsImageView: UIImageView! {set get}
    var rightNameLabel: UILabel! {set get}
}

extension MatchViewPresenter {
    func map(item: MatchPresenter?) {
        guard let match = item else { return }
        leftNameLabel.text = match.leftTeamNameText
        rightNameLabel.text = match.rightTeamNameText
    }
}
