//
//  NameSearchViewController.swift
//  test-app-github
//
//  Created by Элина on 21.10.2020.
//  Copyright © 2020 Элина. All rights reserved.
//

import UIKit

class NameSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var store = RepoStorage.shared
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as! NameSearchTableViewCell
            cell.repo = store.repositories[indexPath.row]
        
        if UserDefaults.standard.bool(forKey: cell.repo!.name) {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = store.repositories[indexPath.row]
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
        
        UserDefaults.standard.set(true, forKey: repo.name)
        UIApplication.shared.open(repo.html_url)
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        guard let text = searchField.text else {return}
        store.getRepositoriesFromAPI(name: text, completion: {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    

}

class NameSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    var repo: Repository? {
        didSet {
            self.nameLabel.text = repo?.name
        }
    }
}
