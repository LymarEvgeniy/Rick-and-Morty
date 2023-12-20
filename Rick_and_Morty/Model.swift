//
//  Model.swift
//  Rick_and_Morty
//
//  Created by Евгений on 16.12.2023.
//

import Foundation

struct CharacterInfo: Codable {
    let name: String
    let status: String
    let species: String
    let type: String
    let image: String
    let gender: String
    let location: Location
    
    struct Location: Codable {
        let name: String
    }
    
}
struct Resalt: Codable {
    let results: [Episode]
}
struct Episode: Codable {
    let id: Int
    let name: String
    let episode: String
    let characters: [String]
}
