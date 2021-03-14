//
//  FriendsViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let friends: [User] = User.loadUsers()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Segues
    
    @IBOutlet weak var tableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PhotosViewController, let indexPath = tableView.indexPathForSelectedRow {
            controller.images = friends[indexPath.row].images
        }
    }
    
    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    // MARK: - Table view delegate
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendsCell
        cell.configureCell(friend: friends[indexPath.row])
        return cell
    }
    
    // MARK: - Actions
    
    @IBAction func choosenFriend(_ sender: FriendsSelectorControl) {
        
        var index: UInt = 0
        for friend in friends {
            if sender.selectedValue?.surname == friend.surname {
                break
            }
            index += 1
        }
        
        let indexPath = IndexPath(row: Int(index), section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        
    }
    
}
