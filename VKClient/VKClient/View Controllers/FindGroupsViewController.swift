//
//  FindGroupsViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit

class FindGroupsViewController: UITableViewController {
    
    let groups: [Group] = [
        Group(name: "Admins", id: 1),
        Group(name: "Users", id: 2)
    ]
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindGroupsCell", for: indexPath) as! FindGroupsCell
        cell.findGroupsLabel?.text = groups[indexPath.row].name
        return cell
    }
    
}
