//
//  FriendsViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit
import RealmSwift

class FriendsViewController: UIViewController {
    
    var realmFriends: [RealmUserModelItem] = []
    var realmFriendsForUse: [RealmUserModelItem] = []
    
    var token: NotificationToken?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getFriends(for: Session.shared.userId) { realmFriends in
            self.realmFriends = realmFriends
            self.realmFriendsForUse = realmFriends
            self.tableView.reloadData()
        }
        
        updateFriends()
        
        tableView.register(UINib(nibName: "FriendsCell", bundle: nil), forCellReuseIdentifier: FriendsCell.reuseIdentifier)
        
        tableView.keyboardDismissMode = .onDrag
        
        searchBar.delegate = self
    }
    
    func updateFriends() {
        
        guard let realm = try? Realm() else { return }
        let results = realm.objects(RealmUserModelItem.self)
        
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

// MARK: - Segues
extension FriendsViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PhotosViewController, let indexPath = tableView.indexPathForSelectedRow {
            controller.ownerId = realmFriendsForUse[indexPath.row].id
        }
    }
    
    @IBAction func unwindFromPhotos(_ segue: UIStoryboardSegue) {
        performSegue(withIdentifier: "FromPhotosSegue", sender: nil)
    }
    
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmFriendsForUse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsCell.reuseIdentifier, for: indexPath) as! FriendsCell
        cell.configureCell(object: realmFriendsForUse[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToPhotosSegue", sender: nil)
        hideKeyboard()
    }
    
}

extension FriendsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        realmFriendsForUse = searchText.isEmpty ? realmFriends : realmFriends.filter { (item: RealmUserModelItem) -> Bool in
            return item.lastName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
    
    func hideKeyboard() {
        self.searchBar.endEditing(true)
    }
    
}
