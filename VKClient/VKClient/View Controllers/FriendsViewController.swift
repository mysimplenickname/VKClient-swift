//
//  FriendsViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit

class FriendsViewController: UIViewController {
    
    let friends: [User] = User.loadUsers()
    var friendsForUse: [User] = []
    
    var rawFriends: [UserModelItem] = []
    var rawFriendsForUse: [UserModelItem] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        VKAPIMainClass.getFriends(for: Session.shared.userId) { [weak self] rawFriends in
            self?.rawFriends = rawFriends
            self?.rawFriendsForUse = rawFriends
            self?.tableView.reloadData()
        }
        
        friendsForUse = friends
        
        tableView.register(UINib(nibName: "FriendsCell", bundle: nil), forCellReuseIdentifier: FriendsCell.reuseIdentifier)
        
//        tableView.register(UINib(nibName: "FriendsHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: FriendsHeaderView.reusableId)
        
        tableView.keyboardDismissMode = .onDrag
        
        searchBar.delegate = self
    }

    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PhotosViewController, let indexPath = tableView.indexPathForSelectedRow {
//            VKAPIMainClass.getPhotos(ownerId: rawFriendsForUse[indexPath.row].id) { rawPhotos in
//                controller.rawImages = rawPhotos
//                print(rawPhotos)
//            }
            controller.ownerId = rawFriendsForUse[indexPath.row].id
//            controller.images = User.arrangeUsers(users: friendsForUse)[indexPath.section][indexPath.row].images
        }
    }
    
    @IBAction func unwindFromPhotos(_ segue: UIStoryboardSegue) {
        performSegue(withIdentifier: "FromPhotosSegue", sender: nil)
    }
    
    // MARK: - Actions
    
//    @IBAction func choosenFriend(_ sender: FriendsSelectorControl) {
//        var row: Int = 0,
//            section: Int = 0
//
//        let arrangedUsers: [[User]] = User.arrangeUsers(users: friendsForUse)
//
//        for i in 0..<arrangedUsers.count {
//            for j in 0..<arrangedUsers[i].count {
//                if arrangedUsers[i][j].last_name == sender.selectedValue?.last_name {
//                    row = j
//                    section = i
//                    break
//                }
//            }
//        }
//
//        let indexPath = IndexPath(row: row, section: section)
//        if tableView.numberOfSections > 0 {
//            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
//        }
//    }
    
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return User.firstLetters(users: friendsForUse).count
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return User.arrangeUsers(users: friendsForUse)[section].count
        return rawFriendsForUse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsCell.reuseIdentifier, for: indexPath) as! FriendsCell
//        cell.configureCell(object: User.arrangeUsers(users: friendsForUse)[indexPath.section][indexPath.row])
        cell.configureCell(object: rawFriendsForUse[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToPhotosSegue", sender: nil)
        hideKeyboard()
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FriendsHeaderView.reusableId) as? FriendsHeaderView
//        headerView?.textLabel?.text = String(User.firstLetters(users: friendsForUse)[section])
//        return headerView
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return FriendsHeaderView.height
//    }
    
}

extension FriendsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            rawFriendsForUse = searchText.isEmpty ? rawFriends : rawFriends.filter { (item: UserModelItem) -> Bool in
                return item.lastName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
            tableView.reloadData()
    }
    
    func hideKeyboard() {
        self.searchBar.endEditing(true)
    }
    
}
