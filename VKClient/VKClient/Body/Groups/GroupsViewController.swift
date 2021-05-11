//
//  GroupsViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit
import RealmSwift

class GroupsViewController: UITableViewController {
    
    var realmGroups: [RealmGroupModelItem] = []
    
    var token: NotificationToken?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGroups(for: Session.shared.userId) { realmGroups in
            self.realmGroups = realmGroups
            self.tableView.reloadData()
        }
        
        updateGroups()
        
        tableView.register(UINib(nibName: "GroupsCell", bundle: nil), forCellReuseIdentifier: GroupsCell.reuseIdentifier)
    }
    
    func updateGroups() {
        
        guard let realm = try? Realm() else { return }
        let results = realm.objects(RealmGroupModelItem.self)
        
        token = results.observe { (changes: RealmCollectionChange) in
            guard let tableView = self.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                tableView.beginUpdates()
                tableView.insertRows(
                    at: insertions.map(
                        {
                            IndexPath(row: $0, section: 0)
                        }
                    ),
                    with: .automatic
                )
                tableView.deleteRows(
                    at: deletions.map(
                        {
                            IndexPath(row: $0, section: 0)
                        }
                    ),
                    with: .automatic
                )
                tableView.reloadRows(
                    at: modifications.map(
                        {
                            IndexPath(row: $0, section: 0)
                        }
                    ),
                    with: .automatic
                )
                tableView.endUpdates()
            case .error(let error):
                fatalError("\(error)")
            }
        }
    }

}

extension GroupsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsCell.reuseIdentifier, for: indexPath) as! GroupsCell
        cell.configureCell(object: realmGroups[indexPath.row])
        return cell
    }
    
}
