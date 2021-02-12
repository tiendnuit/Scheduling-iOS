//
//  SectionModelType.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation

public protocol SectionModelType {
    associatedtype Item

    var items: [Item] { get }
    init(original: Self, items: [Item])
}
