//
//  Client.swift
//  test-app-github
//
//  Created by Элина on 21.10.2020.
//  Copyright © 2020 Элина. All rights reserved.
//

import Foundation

class Client {
    
    class func getRepositories(completion: @escaping ([Repository]) -> ()) {
        let urlString = "https://api.github.com/repositories?client_id=\(APIparts().clientID)&client_secret=\(APIparts().clientSecret)"
        
//        let urlString = "https://api.github.com/search/repositories?q=name:\(key)+in:name&sort=stars&order=desc"
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
                        let result = try JSONDecoder().decode([Repository].self, from: data)
                        completion(result)
                    } catch {
                        print("Something didn't work")
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
