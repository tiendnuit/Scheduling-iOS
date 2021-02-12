//
//  Team.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation

struct Team {
    let name: String
    
    func updateName(_ name: String) -> Team {
        return Team(name: name)
    }
}
