//
//  FriendsViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit

class FriendsViewController: UITableViewController {

    let friends: [User] = [
        User(name: "Adam", surname: "Willson", images: []),
        User(name: "Alex", surname: "Smith", images: []),
        User(name: "John", surname: "Snow", images: ["johnsnow1", "johnsnow2", "johnsnow3"])
    ]
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PhotosViewController, let indexPath = tableView.indexPathForSelectedRow {
            controller.images = friends[indexPath.row].images
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "friendsCell", for: indexPath) as! FriendsCell
        
        let friend = friends[indexPath.row]
        
        cell.friendLabel.text = friend.name + " " + friend.surname
        
        if friend.images.count > 0 {
            cell.friendImage.image = UIImage(named: friend.images[0])
        } else {
            cell.friendImage.image = UIImage(systemName: "person")
        }
        
        return cell
    }
}
