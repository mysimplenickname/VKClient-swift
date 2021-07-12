//
//  FriendsViewController.swift
//  VKClient
//
//  Created by Lev on 2/28/21.
//

import UIKit
import Alamofire

class FriendsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    var friends: [UserModelItem] = []
    var friendsForUse: [UserModelItem] = []
    
    private var imageService: ImageService?
    
    private let myOwnQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFriends()
        
        imageService = ImageService(container: tableView)
        
        tableView.register(UINib(nibName: "FriendsCell", bundle: nil), forCellReuseIdentifier: FriendsCell.reuseIdentifier)
        
        tableView.keyboardDismissMode = .onDrag
        
        searchBar.delegate = self
    }
    
    private func getFriends() {
        let parameters: Parameters = [
            "fields": "photo_100",
            "user_id": Session.shared.userId,
            "access_token": Session.shared.token,
            "v": "5.131"
        ]
        
        let request = Alamofire.request("https://api.vk.com/method/friends.get", method: .get, parameters: parameters)
        
        let getDataOperation = GetDataOperation(request: request)
        myOwnQueue.addOperation(getDataOperation)
        
        let parseDataOperation = ParseDataOperation<UserModel>()
        parseDataOperation.addDependency(getDataOperation)
        myOwnQueue.addOperation(parseDataOperation)
        
        let reloadTableOperation = ReloadTableOperation<UserModel>(controller: self)
        reloadTableOperation.addDependency(parseDataOperation)
        OperationQueue.main.addOperation(reloadTableOperation)
    }
    
}

extension FriendsViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PhotosViewController, let indexPath = tableView.indexPathForSelectedRow {
            controller.ownerId = friendsForUse[indexPath.row].id
        }
    }
    
    @IBAction private func unwindFromPhotos(_ segue: UIStoryboardSegue) {
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
    
    private func hideKeyboard() {
        self.searchBar.endEditing(true)
    }
    
}
