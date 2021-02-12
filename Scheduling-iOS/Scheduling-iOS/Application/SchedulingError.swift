//
//  SchedulingError.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 12/02/2021.
//

import Foundation

struct SchedulingError: Error {
    var code: Int
    var message: String

    static var NameExists = SchedulingError(code: 0, message: "This name already exists!")
    static var InvalidPoolSize = SchedulingError(code: 0, message: "Pool's size should be even and larger or equal to 2")
    static var InvalidTeamSize = SchedulingError(code: 0, message: "Team's size should larger or equal to 2")
    
    var errorDescription: String? {
        return message
    }
    
    static func error(_ error: Error) -> SchedulingError {
        return SchedulingError(code: 0, message: error.localizedDescription)
    }
}
