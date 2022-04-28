//
//  PokeDetail.swift
//  ProjectMVVM
//
//  Created by Linder Anderson Hassinger Solano    on 28/04/22.
//

import Foundation

struct PokeDetail: Codable {
    
    let name: String
    let weight: Int
    let sprites: Sprites
    let types: [Types]
}

struct Sprites: Codable {
    let other: Other
}

struct Other: Codable {
    let officialArtwork: Official
    
    // vamos a crear un alias para el nombre
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct Official: Codable {
    let front_default: String
}

struct Types: Codable {
    let slot: Int
    let type: TypePoke
}

struct TypePoke: Codable {
    let name: String
    let url: String
}
