//
//  RepoViewController.swift
//  test-app-github
//
//  Created by Элина on 20.10.2020.
//  Copyright © 2020 Элина. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    var repo: Repository? {
        didSet {
            self.nameLabel.text = repo?.name
            self.idLabel.text? = "id: \(repo?.id ?? 0)"
        }
    }
}

class RepoViewController: UITableViewController {

    var resultsController = UITableViewController()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredRepos: [Repository]!
    
    var store = RepoStorage.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: .zero)

        prepareForSearch()
        store.all_repositories.removeAll()
        UserDefaults.standard.set(1, forKey: "all_last")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        
        store.getRepositoriesFromAPI(name: nil, completion: {res in
            if res{
                DispatchQueue.main.async {
                self.tableView.reloadData()
                }
            }
        })
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return self.filteredRepos.count
        } else {
            return store.all_repositories.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! RepoTableViewCell
        if isFiltering() {
            cell.repo = self.filteredRepos[indexPath.row]
        } else {
            cell.repo = store.all_repositories[indexPath.row]
        }
        cell.accessoryType = .none
        if UserDefaults.standard.bool(forKey: cell.repo!.name) {
            cell.accessoryType = .checkmark
        }
        if indexPath.row == store.all_repositories.count - 1 {
            UserDefaults.standard.set(store.all_repositories[indexPath.row].id, forKey: "all_last")
            store.getRepositoriesFromAPI(name: nil, completion: { res in
                if res{
                    DispatchQueue.main.async {
                    self.tableView.reloadData()
                    }
                }
            })
        }
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repo = store.all_repositories[indexPath.row]
        UIApplication.shared.open(repo.html_url)
        UserDefaults.standard.set(true, forKey: repo.name)
        if let cell = tableView.cellForRow(at: indexPath) {
                   cell.accessoryType = .checkmark
               }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return !isFiltering()
    }
}

extension RepoViewController: UISearchResultsUpdating {
    
    func prepareForSearch(){
        self.searchController.searchResultsUpdater = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Repositories"
        navigationItem.searchController = self.searchController
        definesPresentationContext = true

        self.resultsController.tableView.dataSource = self
        self.resultsController.tableView.delegate = self
    }

    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }

    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

    func numbersContainSubstringOf(_ part: String, source: [String]) -> Bool {
        for element in source {
            if element.contains(part) {
                return true
            }
        }
        return false
    }

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        self.filteredRepos = store.all_repositories.filter { (repo: Repository) -> Bool in
            guard let text = searchBar.text?.lowercased() else { return false }
            return repo.name.lowercased().contains(text)
        }
        self.tableView.reloadData()
    }
}

