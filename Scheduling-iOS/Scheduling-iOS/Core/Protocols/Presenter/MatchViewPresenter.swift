//
//  MatchViewPresenter.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 12/02/2021.
//

import Foundation
import UIKit

protocol MatchViewPresenter {
    var nameLabel: UILabel! {set get}
}

extension MatchViewPresenter {
    func map(item: MatchPresenter?) {
        guard let match = item else { return }
        nameLabel?.text = match.leftTeamNameText + " vs " + match.rightTeamNameText
    }
}
