//
//  FindGroupsViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit

class FindGroupsViewController: UITableViewController {
    
    let groups: [Group] = [
        Group(name: "Admins", image: nil),
        Group(name: "Users",  image: nil)
    ]
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FindGroupsCell", bundle: nil), forCellReuseIdentifier: FindGroupsCell.reuseIdentifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FindGroupsCell.reuseIdentifier, for: indexPath) as! FindGroupsCell
        
        let group = groups[indexPath.row]
        
        cell.configureCell(object: group)
        
        return cell
    }
    
}
