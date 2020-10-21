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
    private init() {}
    
    var all_repositories = [Repository]()
    var name_repositories = [Repository]()
    
    func getRepositoriesFromAPI(name: String?, completion: @escaping (Bool) -> ()) {
        if let name = name {
            Client.getRepositories(name: name, completion: { (data) in
                self.name_repositories.removeAll()
                for i in 0...data.count - 1 {
                    self.name_repositories.append(data[i])
                }
                completion(true)
            })
            
        } else {
            Client.getRepositories(name: nil, completion: { (data) in
                self.all_repositories.removeAll()
                for i in 0...data.count - 1 {
                    self.all_repositories.append(data[i])
                }
                completion(true)
            })
            
        }
        
    }
}
