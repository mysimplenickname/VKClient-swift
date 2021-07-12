//
//  FriendsViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit
import Alamofire

class FriendsViewController: UIViewController {
    
    var imageService: ImageService?
    
    var friends: [UserModelItem] = []
    var friendsForUse: [UserModelItem] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let myOwnQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FriendsCell", bundle: nil), forCellReuseIdentifier: FriendsCell.reuseIdentifier)

        getFriends()
        
        imageService = ImageService(container: tableView)
        
        tableView.keyboardDismissMode = .onDrag
        
        searchBar.delegate = self
    }
    
    func getFriends() {
        let HOST = "https://api.vk.com"
        let path = "/method/friends.get"
        let VERSION = "5.131"
        
        let parameters: Parameters = [
            "fields": "photo_100",
            "user_id": Session.shared.userId,
            "access_token": Session.shared.token,
            "v": VERSION
        ]
        
        let request = Alamofire.request(HOST + path, method: .get, parameters: parameters)
        
        let getDataOperation = GetDataOperation(request: request)
        myOwnQueue.addOperation(getDataOperation)
        
        let parseDataOperation = ParseDataOperation<UserModel>()
        parseDataOperation.addDependency(getDataOperation)
        myOwnQueue.addOperation(parseDataOperation)
        
        let reloadTableOperation = ReloadTableOperation<UserModel, FriendsViewController>(controller: self)
        reloadTableOperation.addDependency(parseDataOperation)
        OperationQueue.main.addOperation(reloadTableOperation)
    }
    
}

// MARK: - Segues
extension FriendsViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PhotosViewController, let indexPath = tableView.indexPathForSelectedRow {
            controller.ownerId = friendsForUse[indexPath.row].id
        }
    }
    
    @IBAction func unwindFromPhotos(_ segue: UIStoryboardSegue) {
        performSegue(withIdentifier: "FromPhotosSegue", sender: nil)
    }
    
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsForUse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsCell.reuseIdentifier, for: indexPath) as! FriendsCell
        guard let imageUrl = friendsForUse[indexPath.row].imageUrl else { return UITableViewCell() }
        let image = imageService?.getImage(atIndexPath: indexPath, byUrl: imageUrl)
        let name = friendsForUse[indexPath.row].fullname
        cell.configureCell(image: image, name: name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToPhotosSegue", sender: nil)
        hideKeyboard()
    }
    
}

extension FriendsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        friendsForUse = searchText.isEmpty ? friends : friendsForUse.filter { (item: UserModelItem) -> Bool in
            return item.lastName.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
    
    func hideKeyboard() {
        self.searchBar.endEditing(true)
    }
    
}
