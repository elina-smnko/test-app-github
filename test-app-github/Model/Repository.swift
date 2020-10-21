//
//  Repository.swift
//  test-app-github
//
//  Created by Элина on 21.10.2020.
//  Copyright © 2020 Элина. All rights reserved.
//

import Foundation

class Repository: Codable {
    var name: String
    var html_url: URL
    //var stars: Int
    
    init(name: String, html_url: String) {
        self.name = name
        let urlString = html_url
        self.html_url = URL(string: urlString)!
        //self.stars = dictionary["watchers_count"] as! Int
    }
}
