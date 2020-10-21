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
    @IBOutlet weak var starsLabel: UILabel!
    
     var repo: Repository? {
        didSet {
            self.nameLabel.text = repo?.name
            self.starsLabel.text = "\(repo?.stars ?? 0)" 
        }
    }
}

class RepoViewController: UITableViewController {

    var resultsController = UITableViewController()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredRepos: [Repository]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: .zero)

        prepareForSearch()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return self.filteredRepos.count
        } else {
            return RepoStorage.repos.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! RepoTableViewCell
        if isFiltering() {
            cell.repo = self.filteredRepos[indexPath.row]
        } else {
            cell.repo = RepoStorage.repos[indexPath.row]
        }
        return cell
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
        for el in source {
            if el.contains(part) {
                return true
            }
        }
        return false
    }

    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        self.filteredRepos = RepoStorage.repos.filter { (repo: Repository) -> Bool in
            guard let text = searchBar.text?.lowercased() else { return false }
            return repo.name.lowercased().contains(text)
        }
        self.tableView.reloadData()
    }
}

