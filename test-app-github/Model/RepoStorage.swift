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
    
    var repositories = [Repository]()
    func getRepositoriesFromAPI(name: String?, completion: @escaping () -> ()) {
        Client.getRepositories(name: name, completion: { (data) in
            for i in 0...data.count - 1 {
                self.repositories.append(data[i])
            }
        })
        completion()
    }
}
