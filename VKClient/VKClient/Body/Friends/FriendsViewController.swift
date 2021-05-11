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
        
        do {
            let realm = try Realm()
            let results = realm.objects(RealmUserModelItem.self)
            realmFriends = Array(results)
            realmFriendsForUse = Array(results)
        } catch {
            print(error)
        }
        
        if realmFriends.count == 0 {
            getFriends(for: Session.shared.userId) { [weak self] realmFriends in
                self?.realmFriends = realmFriends
                self?.realmFriendsForUse = realmFriends
                self?.tableView.reloadData()
            }
        }
        
      //  updateObject(object: RealmUserModelItem.self, notificationToken: nil, tableView: tableView)
        
        tableView.register(UINib(nibName: "FriendsCell", bundle: nil), forCellReuseIdentifier: FriendsCell.reuseIdentifier)
        
        tableView.keyboardDismissMode = .onDrag
        
        searchBar.delegate = self
    }

    // MARK: - Segues
    
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
