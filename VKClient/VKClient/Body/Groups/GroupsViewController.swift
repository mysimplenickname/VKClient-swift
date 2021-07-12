//
//  GroupsViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit
import RealmSwift
import PromiseKit

class GroupsViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    private var groups: [GroupModelItem] = []
    private var groupsForUse: [GroupModelItem] = []
    
    private var imageService: ImageService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGroupsWithPromise()
        
        imageService = ImageService(container: tableView)
        
        tableView.register(UINib(nibName: "GroupsCell", bundle: nil), forCellReuseIdentifier: GroupsCell.reuseIdentifier)
        
        tableView.keyboardDismissMode = .onDrag
        
        searchBar.delegate = self
    }
    
    private func getGroupsWithPromise() {
        firstly {
            getGroups(for: Session.shared.userId)
        }
        .done { rawData in
            self.groups = rawData
            self.groupsForUse = rawData
            self.tableView.reloadData()
        }
        .catch { error in
            print(error)
        }
    }
    
    @IBAction private func workpls(sender: UIButton) {
        performSegue(withIdentifier: "toFindGroupsViewController", sender: sender)
    }

}

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsForUse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsCell.reuseIdentifier, for: indexPath) as! GroupsCell
        guard let imageUrl = groupsForUse[indexPath.row].imageUrl else { return UITableViewCell() }
        let image = imageService?.getImage(atIndexPath: indexPath, byUrl: imageUrl)
        let name = groupsForUse[indexPath.row].name
        cell.configureCell(image: image, name: name)
        return cell
    }
    
}

extension GroupsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        groupsForUse = searchText.isEmpty ? groups : groups.filter { (item: GroupModelItem) -> Bool in
            return item.name.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
    
    private func hideKeyboard() {
        self.searchBar.endEditing(true)
    }
    
}
