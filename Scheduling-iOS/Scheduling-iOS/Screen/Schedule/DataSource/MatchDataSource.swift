//
//  MatchDataSource.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 12/02/2021.
//

import Foundation
import UIKit

class MatchDataSource: NSObject {
    weak var delegate: ListMatchProtocol?
    
    init(delegate: ListMatchProtocol?) {
        self.delegate = delegate
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate
extension MatchDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = delegate?.item(at: indexPath) else {
            fatalError("Item not exists")
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MatchViewCell.typeName, for: indexPath) as! MatchViewCell
        cell.configure(item)
        return cell
    }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CGFloat.defaultCellHeight
//    }
    
}
