//
//  Client.swift
//  test-app-github
//
//  Created by Элина on 21.10.2020.
//  Copyright © 2020 Элина. All rights reserved.
//

import Foundation

class Client {
    
    class func getRepositories(name: String?, completion: @escaping ([Repository]) -> ()) {
        let urlString: String
        let isName: Bool
        let namepage = UserDefaults.standard.integer(forKey: "namepage")
        let all_last = UserDefaults.standard.integer(forKey: "all_last")
        if let name = name {
            urlString = "https://api.github.com/search/repositories?q=\(name)+in:name&sort=stars&order=desc&page=\(namepage)&per_page=30"
            isName = true
        } else {
            urlString = "https://api.github.com/repositories?since=\(all_last)&per_page=30"
            isName = false
        }
        let url = URL(string: urlString)
        if let url = url {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                 print(error.localizedDescription)
                 return
                }
                if let data = data {
                    do {
                        let result: [Repository]
                        if isName {let dict = try JSONDecoder().decode(DictionaryOfRepos.self, from: data); result = dict.items}
                        else{result = try JSONDecoder().decode([Repository].self, from: data) }
                        completion(result)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            task.resume()
        }else {
            print("invalid url")
            return
        }
    }
}
