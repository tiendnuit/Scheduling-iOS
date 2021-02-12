//
//  PoolSection.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation

struct PoolSection {
    var header: String
    var items: [Item]
}

extension PoolSection: SectionModelType {
    typealias Item = Team
    
    init(original: PoolSection, items: [Item]) {
        self = original
        self.items = items
    }
}
