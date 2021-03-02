//
//  FriendsViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit

class FriendsViewController: UITableViewController {

    let friends: [User] = [
        User(name: "Adam", surname: "Willson", id: 1),
        User(name: "Alex", surname: "Smith", id: 2),
        User(name: "John", surname: "Snow", id: 3)
    ]
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        cell.friendLabel?.text = friends[indexPath.row].name + " " + friends[indexPath.row].surname
        return cell
    }
}
