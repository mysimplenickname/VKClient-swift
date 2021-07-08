//
//  FindGroupsViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit

class FindGroupsViewController: UIViewController {
    
    var imageService: ImageService?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var groups = [GroupModelItem]()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FindGroupsCell", bundle: nil), forCellReuseIdentifier: FindGroupsCell.reuseIdentifier)
        
        imageService = ImageService(container: tableView)
        
        tableView.keyboardDismissMode = .onDrag
        
        searchBar.delegate = self
    }

}

// MARK: - Table view data source
extension FindGroupsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FindGroupsCell.reuseIdentifier, for: indexPath) as! FindGroupsCell
        guard let imageUrl = groups[indexPath.row].imageUrl else { return UITableViewCell() }
        let image = imageService?.getImage(atIndexPath: indexPath, byUrl: imageUrl)
        let name = groups[indexPath.row].name
        cell.configureCell(image: image, name: name)
        return cell
    }
    
}

extension FindGroupsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            groups = []
        } else {
            searchGroups(for: Session.shared.userId, searchString: searchText) { [self] rawGroups in
                groups = rawGroups
            }
        }
        tableView.reloadData()
    }
    
}
