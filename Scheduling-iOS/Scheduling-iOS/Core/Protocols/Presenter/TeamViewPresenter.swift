//
//  TeamViewPresenter.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation
import UIKit

protocol TeamViewPresenter {
    var nameLabel: UILabel! {set get}
}

extension TeamViewPresenter {
    func map(item: TeamPresenter?) {
        guard let team = item else { return }
        nameLabel?.text = team.nameText
    }
}
