//
//  RepoStorage.swift
//  test-app-github
//
//  Created by Элина on 21.10.2020.
//  Copyright © 2020 Элина. All rights reserved.
//

import Foundation

class RepoStorage {
    static let shared = RepoStorage()
    
    var all_repositories = [Repository]()
    var name_repositories = [Repository]()
    
    func getRepositoriesFromAPI(name: String?, completion: @escaping (Bool) -> ()) {
            Client.getRepositories(name: name, completion: { (data) in
                for i in 0...data.count - 1 {
                    if name != nil { self.name_repositories.append(data[i]) }
                    else { self.all_repositories.append(data[i]) }
                }
                completion(true)
            })
    }
}
