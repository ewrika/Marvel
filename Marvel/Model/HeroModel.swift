//
//  HeroModel.swift
//  Marvel
//
//  Created by Георгий Борисов on 20.10.2024.
//

import Foundation
import UIKit

struct HeroModel: Decodable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail

    var imageURL: URL? {
        return URL(string:thumbnail.fullPath)
    }
}

struct Thumbnail: Decodable {
    let path: String
    let `extension`: String

    var fullPath: String {
        return "\(path).\(self.extension)"
    }
}

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
