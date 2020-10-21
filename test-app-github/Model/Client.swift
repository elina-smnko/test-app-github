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
        if let name = name {
            urlString = "https://api.github.com/search/repositories?q=\(name)+in:name&sort=stars&order=desc"
            isName = true
            print(urlString)
        } else {
            urlString = "https://api.github.com/repositories?client_id=\(APIparts().clientID)&client_secret=\(APIparts().clientSecret)"
            isName = false
        }
        // URL object
        let url = URL(string: urlString)
        
        // Start URL Session
        if let url = url {
            let session = URLSession.shared
            
            // DataTask object
            let task = session.dataTask(with: url) { (data, response, error) in
                
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
