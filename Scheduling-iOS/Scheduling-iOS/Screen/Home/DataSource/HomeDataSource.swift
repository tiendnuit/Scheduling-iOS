//
//  HomeDataSource.swift
//  Scheduling-iOS
//
//  Created by Scor Doan on 11/02/2021.
//

import Foundation
import UIKit

class HomeDataSource: NSObject {
    weak var delegate: ListPoolProtocol?
    
    init(delegate: ListPoolProtocol?) {
        self.delegate = delegate
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate
extension HomeDataSource: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        delegate?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        delegate?.numberOfItems(at: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "TeamCell"
        guard let item = delegate?.item(at: indexPath) else {
            fatalError("Item not exists")
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = item.name
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = UIColor.label
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let item = delegate?.item(at: indexPath) else {
            fatalError("Item not exists")
        }
        UIAlertController.presentInputAlert("Edit Team's Name", message: item.name) { [weak self] (name) in
            guard name != item.name else { return }
            self?.delegate?.editRowName(name, at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.headerSectionHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: PoolSectionView.typeName)
                            as? PoolSectionView
        else {
            return nil
        }
        
        view.titleLabel.text = delegate?.titleForHeader(section)
        let test = (delegate?.isExpandedSection(at: section) == true) ? "ex" : "co"
        view.expandedButton.setTitle(test, for: .normal)
        view.editPoolNameClosure = { [weak self] name in
            self?.delegate?.editSectionName(name, at: section)
        }
        view.expandeActionClosure = { [weak self] in
            self?.delegate?.expandeSection(at: section)
        }
        return view
    }
    
}
