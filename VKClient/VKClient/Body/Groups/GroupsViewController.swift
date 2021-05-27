//
//  GroupsViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit
import RealmSwift
import FirebaseDatabase

class GroupsViewController: UIViewController {
    
    var realmGroups: [RealmGroupModelItem] = []
    var realmGroupsForUse: [RealmGroupModelItem] = []
    
    var token: NotificationToken?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Life cycle
    
    let ref = Database.database(url: "https://vkclient-dc5b3-default-rtdb.europe-west1.firebasedatabase.app").reference(withPath: "users/\(Session.shared.userId)")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(ref)
        
        getGroups(for: Session.shared.userId) { realmGroups in
            self.realmGroups = realmGroups
            self.realmGroupsForUse = realmGroups
            self.tableView.reloadData()
            
            let groupsRef = self.ref.child("groups")
            
            var groups = [[String: Any]]()
            
            for elem in realmGroups {
                groups.append(FirebaseGroup(name: "", id: elem.id).toAnyObject())
            }
            
            groupsRef.setValue(groups)
        }
        
        updateGroups()
        
        tableView.register(UINib(nibName: "GroupsCell", bundle: nil), forCellReuseIdentifier: GroupsCell.reuseIdentifier)
        
        tableView.keyboardDismissMode = .onDrag
        
        searchBar.delegate = self
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
    
    @IBAction func workpls(sender: UIButton) {
        performSegue(withIdentifier: "toFindGroupsViewController", sender: sender)
    }

}

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmGroupsForUse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsCell.reuseIdentifier, for: indexPath) as! GroupsCell
        cell.configureCell(object: realmGroupsForUse[indexPath.row])
        return cell
    }
    
}

extension GroupsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        realmGroupsForUse = searchText.isEmpty ? realmGroups : realmGroups.filter { (item: RealmGroupModelItem) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
    
    func hideKeyboard() {
        self.searchBar.endEditing(true)
    }
    
}
