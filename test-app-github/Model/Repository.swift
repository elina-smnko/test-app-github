//
//  Repository.swift
//  test-app-github
//
//  Created by Элина on 21.10.2020.
//  Copyright © 2020 Элина. All rights reserved.
//

import Foundation

class Repository {
    var name: String
    var stars: Int
    var url: String
    
    init(name: String, stars: Int, url: String){
        self.name = name
        self.stars = stars
        self.url = url
    }
}
