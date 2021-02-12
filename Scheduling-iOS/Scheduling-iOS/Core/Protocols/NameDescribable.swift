//
//  NameDescribable.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation
import UIKit

protocol NameDescribable: class {
    var typeName: String { get }
    static var typeName: String { get }
}

extension NameDescribable {
    var typeName: String {
        return String(describing: type(of: self))
    }

    static var typeName: String {
        return String(describing: self)
    }
}

extension UITableViewCell: NameDescribable {
}

extension UITableViewHeaderFooterView: NameDescribable{}
