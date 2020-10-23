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
        self.tableView.reloadData()
        store.name_repositories.removeAll()
        UserDefaults.standard.set(1, forKey: "namepage")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return store.name_repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NameCell", for: indexPath) as! NameSearchTableViewCell
            cell.repo = store.name_repositories[indexPath.row]
        cell.accessoryType = .none
        if UserDefaults.standard.bool(forKey: cell.repo!.name) {
            cell.accessoryType = .checkmark
        }
        if indexPath.row == store.name_repositories.count - 1 {
            UserDefaults.standard.set(UserDefaults.standard.integer(forKey: "namepage")+1, forKey: "namepage")
            guard let text = searchField.text else {return NameSearchTableViewCell()}
            store.getRepositoriesFromAPI(name: text, completion: { res in
                if res{
                    DispatchQueue.main.async {
                    self.tableView.reloadData()
                    }
                }
            })
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = store.name_repositories[indexPath.row]
        UIApplication.shared.open(repo.html_url)
        UserDefaults.standard.set(true, forKey: repo.name)
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
    }
    
    @IBAction func searchTapped(_ sender: Any) {
        self.store.name_repositories.removeAll()
        guard let text = searchField.text else {return}
        store.getRepositoriesFromAPI(name: text, completion: { res in
            if res{
                DispatchQueue.main.async {
                self.tableView.reloadData()
                }
            }
        })
    }
    
    

}

class NameSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    
    var repo: Repository? {
        didSet {
            self.nameLabel.text = repo?.name
            self.starLabel.text? = "★\(repo?.watchers_count ?? 0)"
        }
    }
}
