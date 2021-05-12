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
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let realm = try Realm()
            print(realm.objects(RealmGroupModelItem.self))
            let results = realm.objects(RealmGroupModelItem.self)
            realmGroups = Array(results)
        } catch {
            print(error)
        }
        
        if realmGroups.count == 0 {
            getGroups(for: Session.shared.userId) { [weak self] realmGroups in
                self?.realmGroups = realmGroups
                self?.tableView.reloadData()
            }
        }
        
        tableView.register(UINib(nibName: "GroupsCell", bundle: nil), forCellReuseIdentifier: GroupsCell.reuseIdentifier)
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsCell.reuseIdentifier, for: indexPath) as! GroupsCell
        cell.configureCell(object: realmGroups[indexPath.row])
        return cell
    }
    
//    @IBAction func addGroup(segue: UIStoryboardSegue) {
//        if segue.identifier == "addGroup" {
//            let findGroupsController = segue.source as! FindGroupsViewController
//            if let indexPath = findGroupsController.tableView.indexPathForSelectedRow {
//                let group = findGroupsController.groups[indexPath.row]
//                
//                var test: UInt = 0
//                for i in groups {
//                    if i.name == group.name {
//                        test += 1
//                    }
//                }
//                if test == 0 {
//                    groups.append(group)
//                    tableView.reloadData()
//                }
//            }
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            groups.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
    
}
