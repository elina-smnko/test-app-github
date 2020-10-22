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
    var id: Int
    var watchers_count: Int?
    
    init(name: String, html_url: String, watchers_count: Int?, id: Int) {
        self.name = name
        let urlString = html_url
        self.html_url = URL(string: urlString)!
        self.watchers_count = watchers_count
        self.id = id
    }
}
