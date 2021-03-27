//
//  FriendsViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    let friends: [User] = User.loadUsers()
    var friendsForUse: [User] = []
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FriendsCell", bundle: nil), forCellReuseIdentifier: FriendsCell.reusableId)
        
        tableView.register(UINib(nibName: "FriendsHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: FriendsHeaderView.reusableId)
        
        searchBar.delegate = self
        
        friendsForUse = friends
        
        self.tableView.keyboardDismissMode = .onDrag
    }

    // MARK: - Segues
    
    @IBOutlet weak var tableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PhotosViewController, let indexPath = tableView.indexPathForSelectedRow {
            controller.images = User.arrangeUsers(users: friendsForUse)[indexPath.section][indexPath.row].images
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToPhotosSegue", sender: nil)
        hideKeyboard()
    }
    
    @IBAction func unwindFromPhotos(_ segue: UIStoryboardSegue) {
        performSegue(withIdentifier: "FromPhotosSegue", sender: nil)
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return User.firstLetters(users: friendsForUse).count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return User.arrangeUsers(users: friendsForUse)[section].count
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsCell.reusableId, for: indexPath) as! FriendsCell
        cell.configureCell(friend: User.arrangeUsers(users: friendsForUse)[indexPath.section][indexPath.row])
        return cell
    }
    
    // MARK: - Sections

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FriendsHeaderView.reusableId) as? FriendsHeaderView
        headerView?.textLabel?.text = String(User.firstLetters(users: friendsForUse)[section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return FriendsHeaderView.height
    }
    
    // MARK: - Actions
    
    @IBAction func choosenFriend(_ sender: FriendsSelectorControl) {
        var row: Int = 0,
            section: Int = 0
        
        let arrangedUsers: [[User]] = User.arrangeUsers(users: friendsForUse)
        
        for i in 0..<arrangedUsers.count {
            for j in 0..<arrangedUsers[i].count {
                if arrangedUsers[i][j].surname == sender.selectedValue?.surname {
                    row = j
                    section = i
                    break
                }
            }
        }
        
        let indexPath = IndexPath(row: row, section: section)
        if tableView.numberOfSections > 0 {
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    // MARK: - Search bar
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            friendsForUse = searchText.isEmpty ? friends : friends.filter { (item: User) -> Bool in
                return item.fullname.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
            tableView.reloadData()
    }
    
    func hideKeyboard() {
        self.searchBar.endEditing(true)
    }
    
}
