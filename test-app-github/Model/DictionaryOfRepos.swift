//
//  DictionaryOfRepos.swift
//  test-app-github
//
//  Created by Элина on 21.10.2020.
//  Copyright © 2020 Элина. All rights reserved.
//

import Foundation

struct DictionaryOfRepos: Codable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [Repository]
}
