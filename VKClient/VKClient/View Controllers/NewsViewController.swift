//
//  NewsViewController.swift
//  VKClient
//
//  Created by Lev on 3/21/21.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: NewsCell.reuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseIdentifier, for: indexPath) as! NewsCell
        cell.newsTextLabel?.text = "Hello!"
        cell.newsImageView?.image = UIImage(named: "johnsnow1")
        return cell
    }

}
