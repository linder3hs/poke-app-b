//
//  Pokemon.swift
//  ProjectMVVM
//
//  Created by Linder Anderson Hassinger Solano    on 22/04/22.
//

import Foundation

struct Pokemon: Decodable {
    
    let count: Int
    let next: String
    let results: [Result]
}

struct Result: Decodable {
    
    let name: String
    let url: String
}
