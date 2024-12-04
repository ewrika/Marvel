//
//  MarvelApiModel.swift
//  Marvel
//
//  Created by Георгий Борисов on 04.12.2024.
//

import Foundation

struct CharacterResponse: Decodable {
    let data: CharacterData
}

struct CharacterData: Decodable {
    let results: [HeroModel]
}

struct Character: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail
}
